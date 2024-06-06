USE [ProyectoTelefonos]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[AperturaCierreEstadosCuenta]
	@inFechaOperacion AS DATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION tAC_EstadoCuenta
		--------------- Declaración de variables ---------------
		DECLARE @Fecha_Pago DATE;

		-------------- Inicializacion de variables ---------------
		SET @Fecha_Pago = DATEADD(MONTH, 1, @inFechaOperacion);

		--------------- Validación e Inserción de Facturas ---------------
        -- Insertar una nueva factura si la @inFechaOperacion es igual a alguna FechaPago de las facturas anteriores
        --IF EXISTS (
        --    SELECT 1 
        --    FROM Facturas F 
        --    WHERE F.FechaPago = @inFechaOperacion
        --)
        --BEGIN
        --    -- Insertar la nueva factura relacionada al contrato correspondiente
        --    INSERT INTO [dbo].[Facturas](
        --        ID_Contrato,
        --        FechaEmision,
        --        FechaPago,
        --        TotalAPagar,
        --        Estado
        --    )
        --    SELECT
        --        C.Id AS ID_Contrato,
        --        @inFechaOperacion AS Fecha_Emision,
        --        @Fecha_Pago AS Fecha_Pago,
        --        0 AS TotalAPagar,            -- El total a pagar se actualiza conforme a los detalles
        --        0 AS Estado                  -- Inicializa la factura como PENDIENTE
        --    FROM Contrato C
        --    JOIN Facturas F ON F.ID_Contrato = C.Id
        --    WHERE F.FechaPago = @inFechaOperacion;
        --END

        ---- Insertar las facturas basadas en los contratos con la fecha de operación actual
        --INSERT INTO [dbo].[Facturas](
        --    ID_Contrato,
        --    FechaEmision,
        --    FechaPago,
        --    TotalAPagar,
        --    Estado
        --)
        --SELECT
        --    C.Id AS ID_Contrato,
        --    @inFechaOperacion AS Fecha_Emision,
        --    @Fecha_Pago AS Fecha_Pago,
        --    0 AS TotalAPagar,            -- El total a pagar se actualiza conforme a los detalles
        --    0 AS Estado                  -- Inicializa la factura como PENDIENTE
        --FROM Contrato C
        --WHERE C.Fecha = @inFechaOperacion;
		-----------------------------------------------------------------
        COMMIT TRANSACTION tAC_EstadoCuenta

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE() AS ErrorMessage
    END CATCH
END

