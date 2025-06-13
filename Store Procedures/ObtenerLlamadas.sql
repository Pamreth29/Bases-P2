USE [NewTelefoneria]
GO
/****** Object:  StoredProcedure [dbo].[ObtenerLlamadas]    Script Date: 9/6/2024 12:03:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ObtenerLlamadas]
    @inNumero VARCHAR(64)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION TObtenerFacturas

        SELECT
            l.FechaHora_Inicio,
            l.FechaHora_Fin,
            l.NumeroA,
            dl.Duracion,
            dl.ID_TipoMinutos1 -- devuelve 9 o No. Cuando devuelve 9 significa que es llamada gratis
        FROM [dbo].[Llamadas] l
        JOIN [dbo].[DetalleLlamadas] dl ON dl.ID_Llamada = l.Id
        WHERE l.NumeroDe = @inNumero;

        COMMIT TRANSACTION TObtenerFacturas

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH

    SET NOCOUNT OFF;
END
