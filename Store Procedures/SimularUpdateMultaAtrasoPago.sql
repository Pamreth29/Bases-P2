USE [NewTelefoneria]
GO
/****** Object:  StoredProcedure [dbo].[SimularUpdateMultaAtrasoPago]    Script Date: 9/6/2024 12:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SimularUpdateMultaAtrasoPago]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION TActualizarMultaAtrasoPago

        -- Este SP básicamente suple la carencia de los días de 2024-05-05 hasta los días 2024-06-15 en el XML
        -- ¿Por qué se necesita? porque existen facturas que se crean incluso hasta el 2024-05-04, sin embargo en 
        -- la simulación convencional, la fecha operación llega hasta el 2024-05-04, por lo que no se podría verificar
        -- la MultaAtrasoPago para esas facturas que no se han cerrado antes del 2024-05-04

        DECLARE @inFechaOperacion DATE;
        SET @inFechaOperacion = '2024-05-05';

        WHILE @inFechaOperacion <= '2024-06-15'
        BEGIN
            UPDATE f2
            SET MultaAtrasoPago = ett.Valor
            FROM [dbo].[Factura] f2
            JOIN [dbo].[Factura] f1 ON f2.ID_Contrato = f1.ID_Contrato
            JOIN [dbo].[Contrato] c ON c.Id = f1.ID_Contrato 
            JOIN [dbo].[ElementoTipoTarifa] ett ON ett.ID_TipoTarifa = c.ID_TipoTarifa 
                AND ett.ID_TipoElemento = 7
            WHERE c.ID_TipoTarifa < 7
            AND f1.FechaPago IS NULL
            AND f2.FechaPago IS NULL
            AND (
                (DATEADD(MONTH, 1, f1.FechaFactura) <= '2024-05-05' AND f1.FechaLimitePago < @inFechaOperacion)
                OR (DATEADD(MONTH, 1, f1.FechaFactura) > '2024-05-05')
            )
            AND DATEADD(MONTH, 1, f1.FechaFactura) = f2.FechaFactura;

            -- Incrementar la fecha de operación en un día
            SET @inFechaOperacion = DATEADD(DAY, 1, @inFechaOperacion);
        END

        COMMIT TRANSACTION TActualizarMultaAtrasoPago

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH

    SET NOCOUNT OFF;
END
