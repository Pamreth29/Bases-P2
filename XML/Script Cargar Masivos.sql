USE [NewTelefoneria]

DECLARE @XML AS XML;
DECLARE @id AS INT;
DECLARE @FechaActual AS DATE;
DECLARE @FechaOperacion TABLE (Fecha DATE);

-- Cargar el archivo XML en una variable XML
SELECT @XML = P.X
FROM OPENROWSET(BULK 'C:\Program Files\Microsoft SQL Server\MSSQL16.HIATUXHIATUSBD\MSSQL\operacionesMasivas.xml', SINGLE_BLOB) AS P(X);

-- Crear un identificador de documento XML
EXEC sp_xml_preparedocument @id OUTPUT, @XML;

INSERT INTO @FechaOperacion (Fecha)
SELECT DISTINCT FechaOperacion.value ('@fecha', 'DATE') AS Fecha
FROM @XML.nodes('/Operaciones/FechaOperacion') AS T(FechaOperacion);

DECLARE @OutResultCode INT;

WHILE EXISTS (SELECT 1 FROM @FechaOperacion)
BEGIN
    DECLARE @DatosDiarios TABLE (Fecha DATE, Operacion XML);

    DECLARE @RelacionFamiliarTemporal TABLE (
        Fecha DATE,
        NumIdentificacionDe VARCHAR(64),
        NumIdentificacionA VARCHAR(64),
        TipoRelacion INT
    );

    SELECT TOP 1 @FechaActual = Fecha FROM @FechaOperacion ORDER BY Fecha;

    INSERT INTO @DatosDiarios (Fecha, Operacion)
    SELECT
        FechaOperacion.value('@fecha', 'DATE') AS Fecha,
        FechaOperacion.query('.') AS Datos
    FROM @XML.nodes('/Operaciones/FechaOperacion') AS T(FechaOperacion)
    WHERE FechaOperacion.value('@fecha', 'DATE') = @FechaActual;

    ------------CARGAR DATOS-----------------

    -- Cargar Clientes
     INSERT INTO dbo.Clientes (NumIdentificacion, Nombre)
     SELECT
         ClienteNuevo.value('@Identificacion', 'VARCHAR(64)') AS NumIdentificacion,
         ClienteNuevo.value('@Nombre', 'VARCHAR(64)') AS Nombre
     FROM @DatosDiarios AS DD
     CROSS APPLY DD.Operacion.nodes('/FechaOperacion/ClienteNuevo') AS T(ClienteNuevo);

	 	----- Cargar Relacion Familiar
	INSERT INTO dbo.RelacionFamiliar(ID_Cliente1, ID_Cliente2, ID_TipoRelacionFamilair)
	SELECT
		C1.Id,
		C2.Id,
		TRF.Id
	FROM @DatosDiarios AS DD
	CROSS APPLY DD.Operacion.nodes('/FechaOperacion/RelacionFamiliar') AS T(RelacionFamiliar)
	JOIN dbo.Clientes C1 ON RelacionFamiliar.value('@DocIdDe', 'VARCHAR(64)') = C1.NumIdentificacion
	JOIN dbo.Clientes C2 ON RelacionFamiliar.value('@DocIdA', 'VARCHAR(64)') = C2.NumIdentificacion
	JOIN dbo.TipoRelacionFamiliar TRF ON RelacionFamiliar.value('@TipoRelacion', 'INT') = TRF.Id;

    -- Cargar Contratos
    INSERT INTO dbo.Contrato (ID_Cliente, ID_TipoTarifa, Numero, Fecha)
    SELECT
        C.Id AS ID_Cliente,
        NuevoContrato.value('@TipoTarifa', 'INT') AS ID_TipoTarifa,
        NuevoContrato.value('@Numero', 'VARCHAR(64)') AS Numero,
        DD.Fecha
    FROM @DatosDiarios AS DD
    CROSS APPLY DD.Operacion.nodes('/FechaOperacion/NuevoContrato') AS T(NuevoContrato)
    JOIN dbo.Clientes C ON NuevoContrato.value('@DocIdCliente', 'VARCHAR(64)') = C.NumIdentificacion;

	-- Crear una tabla temporal para almacenar los n�meros de factura extra�dos del XML
	DECLARE @TempPagoFactura TABLE (
		Numero VARCHAR(64),
		Fecha DATE
	);

	------------------------ Actualizacion de Columna FechaPAgo en tabla Factura--------------------------------
	INSERT INTO @TempPagoFactura (Numero, Fecha)
	SELECT
		T.PagoFactura.value('@Numero', 'VARCHAR(64)') AS Numero,
		DD.Fecha
	FROM @DatosDiarios AS DD
	CROSS APPLY DD.Operacion.nodes('/FechaOperacion/PagoFactura') AS T(PagoFactura);

	UPDATE F
	SET F.FechaPago = TP.Fecha
	FROM dbo.Factura F
	JOIN dbo.Contrato C ON F.ID_Contrato = C.Id
	JOIN @TempPagoFactura TP ON C.Numero = TP.Numero
	WHERE (F.FechaLimitePago IS NULL OR TP.Fecha BETWEEN DATEADD(MONTH, 1, F.FechaFactura) AND F.FechaLimitePago)
	AND TP.Fecha >= DATEADD(MONTH, 1, F.FechaFactura);
	--------------------------------------------------------------------------------------------------------------

	-- Cargar Llamadas
	INSERT INTO dbo.Llamadas (NumeroDe, NumeroA, FechaHora_Inicio, FechaHora_Fin)
	SELECT
		NuevoContrato.value('@NumeroDe', 'VARCHAR(64)') AS NumeroDe,
		NuevoContrato.value('@NumeroA', 'VARCHAR(64)') AS NumeroA,
		TRY_CONVERT(DATETIME, NuevoContrato.value('@Inicio', 'VARCHAR(64)')) AS FechaHora_Inicio,
		TRY_CONVERT(DATETIME, NuevoContrato.value('@Final', 'VARCHAR(64)')) AS FechaHora_Fin
	FROM @DatosDiarios AS DD
	CROSS APPLY DD.Operacion.nodes('/FechaOperacion/LlamadaTelefonica') AS T(NuevoContrato)

		-- Se realiza la apertura y cierre de facturas de acuerdo a la fecha de operacion
    EXEC dbo.AperturaCierreFactura @inFechaOperacion = @FechaActual, @OutResultCode = @OutResultCode OUTPUT;
	
	--APERTURA DE ESTADOS DE CUENTA
	EXEC  [dbo].[AperturaCierreEstadosCuenta] @inFechaOperacion = @FechaActual, @OutResultCode = @OutResultCode OUTPUT;

	--Para insertar las llamadas que no son locales
	EXEC [dbo].[InsertarNoLocales] @inFechaOperacion = @FechaActual, @OutResultCode = @OutResultCode OUTPUT;


	-- Cargar Uso Datos
	INSERT INTO dbo.UsoDatos(Fecha, Numero, QGigas)
	SELECT
		DD.Fecha,
		UsoDatos.value('@Numero', 'VARCHAR(64)') AS Numero,
		UsoDatos.value('@QGigas', 'float') AS QGigas
	FROM @DatosDiarios AS DD
	CROSS APPLY DD.Operacion.nodes('/FechaOperacion/UsoDatos') AS T(UsoDatos)

	EXEC dbo.CargaSubDetalles @inFechaOperacion = @FechaActual, @OutResultCode = @OutResultCode OUTPUT;

	EXEC dbo.ActualizarDatosFactura @inFechaOperacion = @FechaActual, @OutResultCode = @OutResultCode OUTPUT;
	IF DAY(@FechaActual) = 5
		BEGIN
			-- Ejecuta el procedimiento almacenado
			EXEC [dbo].[ActualizarDatosEstadosCuenta] @inFechaOperacion = @FechaActual, @OutResultCode = @OutResultCode OUTPUT;
		END

	--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! NO comentar nunca
    DELETE FROM @FechaOperacion WHERE Fecha = @FechaActual;
    DELETE FROM @DatosDiarios WHERE Fecha = @FechaActual;
	--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! NO comentar nunca

END;

	EXEC SimularUpdateMultaAtrasoPago @OutResultCode = @OutResultCode OUTPUT;

-- Liberar el documento XML
EXEC sp_xml_removedocument @id;