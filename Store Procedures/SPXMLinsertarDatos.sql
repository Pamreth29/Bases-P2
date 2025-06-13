USE [NewTelefoneria]
GO
/****** Object:  StoredProcedure [dbo].[SPXMLinsertarDatos]    Script Date: 9/6/2024 12:03:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SPXMLinsertarDatos]
    @xml AS XML
AS
BEGIN
	SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION tranInsertarDatosXML

        DECLARE @xQuery AS XML = (SELECT CAST(@xml AS XML))

        -------------------------------------------------------------------------
        --Insertar datos en la tabla TipoUnidad
        INSERT INTO [dbo].[TipoUnidad]
        (
          Id,
          Nombre
        )
        SELECT
          x.value('@Id', 'INT'),
          x.value('@Tipo', 'VARCHAR(64)')
        FROM @xQuery.nodes('/Data/TiposUnidades/TipoUnidad') AS TempXML (x)

        -----------------------------------------------------------------------
        --Insertar datos en la tabla TipoElemento
        INSERT INTO [dbo].[TipoElemento]
        (
          Id,
          Nombre,
          ID_TipoUnidad,
          EsFijo
        )
        SELECT
          x.value('@Id', 'INT'),
          x.value('@Nombre', 'VARCHAR(64)'),
          x.value('@IdTipoUnidad', 'INT'),
          x.value('@EsFijo', 'BIT')
        FROM @xQuery.nodes('/Data/TiposElemento/TipoElemento') AS TempXML (x)

		 -----------------------------------------------------------------------
        --Insertar datos en la tabla TipoElementoFijo
        INSERT INTO [dbo].[TipoElementoFijo]
        (
          ID_TipoElemento,
          Valor
        )
        SELECT
          x.value('@Id', 'INT'),
          x.value('@Valor', 'INT')
        FROM @xQuery.nodes('/Data/TiposElemento/TipoElemento') AS TempXML (x)
		WHERE x.value('@EsFijo', 'BIT') = 1

        -------------------------------------------------------------------------
        -- Insertar datos en la tabla TipoTarifa
        INSERT INTO [dbo].[TipoTarifa]
        (
          Id,
          Nombre
        )
        SELECT
          x.value('@Id', 'INT'),
          x.value('@Nombre', 'VARCHAR(64)')
        FROM @xQuery.nodes('/Data/TiposTarifa/TipoTarifa') AS TempXML (x)

        -------------------------------------------------------------------------
        -- Insertar datos en la tabla ElementoTipoTarifa
        INSERT INTO [dbo].[ElementoTipoTarifa]
        (
          ID_TipoTarifa,
          ID_TipoElemento,
          Valor
        )
        SELECT
          x.value('@idTipoTarifa', 'INT'),
          x.value('@IdTipoElemento', 'INT'),
          x.value('@Valor', 'INT')
        FROM @xQuery.nodes('/Data/ElementosDeTipoTarifa/ElementoDeTipoTarifa') AS TempXML (x)

        -------------------------------------------------------------------------
        --Insertar datos en la tabla TipoRelacionFamiliar
        INSERT INTO [dbo].[TipoRelacionFamiliar]
        (
          Id,
          Nombre
        )
        SELECT
          x.value('@Id', 'INT'),
          x.value('@Nombre', 'VARCHAR(64)')
        FROM @xQuery.nodes('/Data/TipoRelacionesFamiliar/TipoRelacionFamiliar') AS TempXML (x)

        -------------------------------------------------------------------------
        COMMIT TRANSACTION

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE() AS ErrorMessage
    END CATCH

	SET NOCOUNT OFF;

END
