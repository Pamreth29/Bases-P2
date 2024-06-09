USE [Proyecto2]
GO

/****** Object:  Trigger [dbo].[TG_InsertarTTxETT]    Script Date: 4/6/2024 21:45:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Creación del trigger
CREATE TRIGGER [dbo].[TG_InsertarTTxETT]
ON [dbo].[TipoTarifa]
AFTER INSERT
AS
BEGIN
    -- Manejar errores y transacciones
    BEGIN TRY
        BEGIN TRANSACTION

        -- Insertar los elementos de tipo tarifa con EsFijo = 1 en la tabla TipoTarifaXTipoElemento
        INSERT INTO [dbo].[ElementoTipoTarifa] (ID_TipoTarifa, ID_TipoElemento, Valor)
        SELECT 
            i.Id AS ID_TipoTarifa,
            te.Id AS ID_TipoElemento,
            tef.Valor AS Valor
        FROM 
            Inserted i
        INNER JOIN 
            TipoElemento te ON te.EsFijo = 1
		INNER JOIN
			TipoElementoFijo tef ON te.Id = tef.ID_TipoElemento;

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        -- Manejar el error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

ALTER TABLE [dbo].[TipoTarifa] ENABLE TRIGGER [TG_InsertarTTxETT]
GO

