USE [NewTelefoneria]
GO
/****** Object:  StoredProcedure [dbo].[ObtenerFacturas]    Script Date: 9/6/2024 12:02:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ObtenerFacturas]
    @inNumero VARCHAR(64)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION TObtenerFacturas

        SELECT
            f.FechaFactura,
            f.MultaAtrasoPago,
            f.TotalAntesIVA,
            f.TotalAPagar,
            f.FechaLimitePago
        FROM [dbo].[Factura] f
        JOIN [dbo].[Contrato] c ON c.Id = f.ID_Contrato
        WHERE c.Numero = @inNumero
        ORDER BY f.FechaFactura ASC;

        COMMIT TRANSACTION TObtenerFacturas

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH

    SET NOCOUNT OFF;
END
