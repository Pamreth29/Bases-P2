USE [NewTelefoneria]
GO
/****** Object:  StoredProcedure [dbo].[ObtenerUsoDatos]    Script Date: 9/6/2024 12:03:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ObtenerUsoDatos]
    @inNumero VARCHAR(64)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION TObtenerFacturas

        SELECT
            u.Fecha,
            dud.TotalQGigas
        FROM [dbo].[UsoDatos] u
        JOIN [dbo].[DetalleUsoDatos] dud ON dud.Id = u.ID
        WHERE u.Numero = @inNumero;

        COMMIT TRANSACTION TObtenerFacturas

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH

    SET NOCOUNT OFF;
END
