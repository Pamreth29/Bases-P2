USE [NewTelefoneria]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarDatosFactura]    Script Date: 6/8/2024 4:53:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ObtenerDetallesEstadosCuentaXEmpresa]
	@inNombreEmpresa AS VARCHAR(32),
	@inIDEstadoCuenta AS INT
AS
BEGIN
    BEGIN TRY

		-- Obtener la fecha de corte para el estado de cuenta dado
        DECLARE @FechaCorte DATE;
		DECLARE @FechaInicio DATE;

        SELECT @FechaCorte = ec.FechaCorte
        FROM [dbo].[EstadoCuentaOperador] ec
        WHERE ec.ID = @inIDEstadoCuenta;


		-- Determinar la fecha de inicio
        SELECT @FechaInicio = CASE 
                                WHEN @inIDEstadoCuenta <= 2 THEN '2024-01-01' -- Primeros dos estados de cuenta
                                ELSE (
                                    SELECT TOP 1 ec_anterior.FechaCorte
                                    FROM [dbo].[EstadoCuentaOperador] ec_anterior
                                    WHERE ec_anterior.ID_Operador = (SELECT ID_Operador FROM [dbo].[EstadoCuentaOperador] WHERE ID = @inIDEstadoCuenta)
                                    AND ec_anterior.ID < @inIDEstadoCuenta
                                    ORDER BY ec_anterior.ID DESC
                                )
                              END;

        BEGIN TRANSACTION TObtenerDetallesEC
		----------------------------------------------------------------------------------
			SELECT
				l.ID,
				l.NumeroDe,
				l.NumeroA,
				CASE
					WHEN LEFT(l.NumeroA, 1) = CAST(o.digitoPrefijo AS VARCHAR) THEN 'Saliente'
					WHEN LEFT(l.NumeroDe, 1) = CAST(o.digitoPrefijo AS VARCHAR) THEN 'Entrante'
				END AS TipoLlamada,
				l.FechaHora_Inicio,
				l.FechaHora_Fin,
				CASE
					WHEN LEFT(l.NumeroA, 1) = CAST(o.digitoPrefijo AS VARCHAR) THEN 
						(SELECT SUM(dl.Duracion) FROM [dbo].[DetalleLlamadas] dl WHERE dl.ID_Llamada = l.ID)
					WHEN LEFT(l.NumeroDe, 1) = CAST(o.digitoPrefijo AS VARCHAR) THEN 
						(SELECT SUM(dlnl.Duracion) FROM [dbo].[DetalleLlamadaNoLocal] dlnl WHERE dlnl.ID_LlamadaNoLocal = l.ID)
					ELSE 0
				END AS Duracion
			FROM [dbo].[Llamadas] l
			INNER JOIN [dbo].[Operador] o ON o.Nombre = @inNombreEmpresa
			WHERE o.Nombre = @inNombreEmpresa
			AND (LEFT(l.NumeroDe, 1) = CAST(o.digitoPrefijo AS VARCHAR)
				OR LEFT(l.NumeroA, 1) = CAST(o.digitoPrefijo AS VARCHAR))
			AND l.FechaHora_Inicio >= @FechaInicio  -- Incluir llamadas desde la fecha de inicio
            AND l.FechaHora_Inicio < @FechaCorte;  -- Hasta el final del día de la fecha de corte
		----------------------------------------------------------------------------------
        COMMIT TRANSACTION TObtenerDetallesEC

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE() AS ErrorMessage
    END CATCH
END