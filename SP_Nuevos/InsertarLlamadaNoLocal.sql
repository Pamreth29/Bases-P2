USE [NewTelefoneria]
GO
/****** Object:  StoredProcedure [dbo].[AperturaCierreFactura]    Script Date: 6/8/2024 3:53:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertarNoLocales]
	@inFechaOperacion AS DATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION tLlamadaNoLocal
        
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
			ON LEFT(l.NumeroA, 1) = CAST(o.digitoPrefijo AS VARCHAR)
		WHERE
			CONVERT(DATE, l.fechaHora_Inicio) = @inFechaOperacion;



		-------------------------------------------------------------------------------------------
        COMMIT TRANSACTION tLlamadaNoLocal

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE() AS ErrorMessage
    END CATCH
END

