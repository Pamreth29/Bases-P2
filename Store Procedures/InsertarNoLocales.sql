USE [NewTelefoneria]
GO
/****** Object:  StoredProcedure [dbo].[InsertarNoLocales]    Script Date: 9/6/2024 12:02:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[InsertarNoLocales]
    @inFechaOperacion AS DATE
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION tInsertarNoLocales
        
        ------------------------- INSERTAR LLAMADAS NO LOCALES -----------------------------------

        INSERT INTO [dbo].[LlamadaNoLocal] (
            ID_Llamadas,
            ID_Operador
        )
        SELECT
            l.Id,
            o.Id
        FROM [dbo].[Llamadas] l
        INNER JOIN [dbo].[Operador] o
            ON LEFT(l.NumeroDe, 1) = CAST(o.digitoPrefijo AS VARCHAR)
        WHERE
            CONVERT(DATE, l.FechaHora_Inicio) = @inFechaOperacion;


        
        ------------------------ INSERTAR DETALLE LLAMADAS NO LOCALES -----------------------------

        INSERT INTO [dbo].[DetalleLlamadaNoLocal](
            ID_LlamadaNoLocal,
            ID_TipoMinuto,
            Duracion
        )
        SELECT DISTINCT
            lnl.ID_Llamadas AS ID_LlamadaNoLocal,
            CASE 
                WHEN LEN(l.NumeroDe) = 8 AND LEFT(l.NumeroDe, 1) = '7' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'MinutosEmpresaX')
                WHEN LEN(l.NumeroDe) = 8 AND LEFT(l.NumeroDe, 1) = '6' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'MinutosEmpresaY')
                ELSE 0
            END AS ID_TipoMinutos1,
            DATEDIFF(MINUTE, CONVERT(DATETIME, l.FechaHora_Inicio), CONVERT(DATETIME, l.FechaHora_Fin)) AS Duracion
        FROM 
            [dbo].[LlamadaNoLocal] lnl
        JOIN 
            [dbo].[Llamadas] l ON lnl.ID_Llamadas = l.ID
        WHERE 
            CONVERT(DATE, l.FechaHora_Inicio) = @inFechaOperacion

        COMMIT TRANSACTION tInsertarNoLocales

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE() AS ErrorMessage
    END CATCH

    SET NOCOUNT OFF;

END
