USE [NewTelefoneria]
GO
/****** Object:  StoredProcedure [dbo].[AperturaCierreFactura]    Script Date: 9/6/2024 12:01:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[AperturaCierreFactura]
    @inFechaOperacion AS DATE
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION tAC_Fact;

        ------------- Declaración de variables ---------------
        DECLARE @Fecha_Cierre DATE;
        DECLARE @Contador INT = 1;
        DECLARE @MaxContador INT = 15;
        
        ------------------------- INSERTAR SIGUIENTES FACTURAS -----------------------------------
        IF EXISTS (
            SELECT 1 
            FROM [dbo].[Factura] F 
            WHERE DATEADD(MONTH, 1, F.FechaFactura) = @inFechaOperacion
        )
        BEGIN
            -- Insertar la nueva factura relacionada al contrato correspondiente
            INSERT INTO [dbo].[Factura](
                ID_Contrato,
                FechaFactura,
                FechaLimitePago,
                MultaAtrasoPago,
                TotalAntesIVA,
                MontoIVA,
                TotalAPagar,
                QTotalMinutosAdicionales,
                QTotalMinutosAdicionalesNoche,
                QTotalMinutosZ,
                QTotalMinutosZNoche,
                QTotalMinutos800Recibidos,
                QTotalMinutos900Recibidos,
                QTotalMinutos900Marcados,
                QTotalMinutosEmpresaX,
                QTotalMinutosEmpresaY,
                QTotalMinutos110,
                QTotalLlamadas911,
                FechaPago,
                QTotalMinutosFamiliares,
                QTotalGigasAdicionales,
                QTotalGigasBase,
                QTotalMinutos800Marcados
            )
            SELECT
                c.Id AS ID_Contrato,
                @inFechaOperacion AS FechaFactura,
                DATEADD(DAY, ett.Valor, DATEADD(MONTH, 1, @inFechaOperacion)) AS FechaLimitePago,
                0 AS MultaAtrasoPago,
                0 AS TotalAntesIVA,
                0 AS MontoIVA,
                0 AS TotalAPagar,
                0 AS QTotalMinutosAdicionales,
                0 AS QTotalMinutosAdicionalesNoche,
                0 AS QTotalMinutosZ,
                0 AS QTotalMinutosZNoche,
                0 AS QTotalMinutos800Recibidos,
                0 AS QTotalMinutos900Recibidos,
                0 AS QTotalMinutos900Marcados,
                0 AS QTotalMinutosEmpresaX,
                0 AS QTotalMinutosEmpresaY,
                0 AS QTotalMinutos110,
                0 AS QTotalLlamadas911,
                NULL AS FechaPago,
                0 AS QTotalMinutosFamiliares,
                0 AS QTotalGigasAdicionales,
                0 AS QTotalGigasBase,
                0 AS QTotalMinutos800Marcados
            FROM [dbo].[Contrato] c
            JOIN [dbo].[ElementoTipoTarifa] ett ON ett.ID_TipoTarifa = c.ID_TipoTarifa AND ett.ID_TipoElemento = 7
            JOIN [dbo].[Factura] f ON f.ID_Contrato = c.Id
            WHERE DATEADD(MONTH, 1, f.FechaFactura) = @inFechaOperacion

            UNION ALL

            SELECT
                c.Id AS ID_Contrato,
                @inFechaOperacion AS FechaFactura,
                NULL AS FechaLimitePago,
                0 AS MultaAtrasoPago,
                0 AS TotalAntesIVA,
                0 AS MontoIVA,
                0 AS TotalAPagar,
                0 AS QTotalMinutosAdicionales,
                0 AS QTotalMinutosAdicionalesNoche,
                0 AS QTotalMinutosZ,
                0 AS QTotalMinutosZNoche,
                0 AS QTotalMinutos800Recibidos,
                0 AS QTotalMinutos900Recibidos,
                0 AS QTotalMinutos900Marcados,
                0 AS QTotalMinutosEmpresaX,
                0 AS QTotalMinutosEmpresaY,
                0 AS QTotalMinutos110,
                0 AS QTotalLlamadas911,
                NULL AS FechaPago,
                0 AS QTotalMinutosFamiliares,
                0 AS QTotalGigasAdicionales,
                0 AS QTotalGigasBase,
                0 AS QTotalMinutos800Marcados
            FROM [dbo].[Contrato] c
            JOIN [dbo].[TipoTarifa] tt ON tt.ID = c.ID_TipoTarifa
            JOIN [dbo].[Factura] f ON f.ID_Contrato = c.Id
            WHERE DATEADD(MONTH, 1, f.FechaFactura) = @inFechaOperacion
              AND (tt.ID = 7 OR tt.ID = 8);
        END

        ------------------------- INSERTAR PRIMERA FACTURA -----------------------------------
        INSERT INTO [dbo].[Factura](
            ID_Contrato,
            FechaFactura,
            FechaLimitePago,
            MultaAtrasoPago,
            TotalAntesIVA,
            MontoIVA,
            TotalAPagar,
            QTotalMinutosAdicionales,
            QTotalMinutosAdicionalesNoche,
            QTotalMinutosZ,
            QTotalMinutosZNoche,
            QTotalMinutos800Recibidos,
            QTotalMinutos900Recibidos,
            QTotalMinutos900Marcados,
            QTotalMinutosEmpresaX,
            QTotalMinutosEmpresaY,
            QTotalMinutos110,
            QTotalLlamadas911,
            FechaPago,
            QTotalMinutosFamiliares,
            QTotalGigasAdicionales,
            QTotalGigasBase,
            QTotalMinutos800Marcados
        )
        SELECT
            c.Id AS ID_Contrato,
            @inFechaOperacion AS FechaFactura,
            DATEADD(DAY, ett.Valor, DATEADD(MONTH, 1, @inFechaOperacion)) AS FechaLimitePago,
            0 AS MultaAtrasoPago,
            0 AS TotalAntesIVA,
            0 AS MontoIVA,
            0 AS TotalAPagar,
            0 AS QTotalMinutosAdicionales,
            0 AS QTotalMinutosAdicionalesNoche,
            0 AS QTotalMinutosZ,
            0 AS QTotalMinutosZNoche,
            0 AS QTotalMinutos800Recibidos,
            0 AS QTotalMinutos900Recibidos,
            0 AS QTotalMinutos900Marcados,
            0 AS QTotalMinutosEmpresaX,
            0 AS QTotalMinutosEmpresaY,
            0 AS QTotalMinutos110,
            0 AS QTotalLlamadas911,
            NULL AS FechaPago,
            0 AS QTotalMinutosFamiliares,
            0 AS QTotalGigasAdicionales,
            0 AS QTotalGigasBase,
            0 AS QTotalMinutos800Marcados
        FROM [dbo].[Contrato] c
        JOIN [dbo].[ElementoTipoTarifa] ett ON ett.ID_TipoTarifa = c.ID_TipoTarifa AND ett.ID_TipoElemento = 7
        WHERE c.Fecha = @inFechaOperacion

        UNION ALL

        SELECT
            c.Id AS ID_Contrato,
            @inFechaOperacion AS FechaFactura,
            NULL AS FechaLimitePago,
            0 AS MultaAtrasoPago,
            0 AS TotalAntesIVA,
            0 AS MontoIVA,
            0 AS TotalAPagar,
            0 AS QTotalMinutosAdicionales,
            0 AS QTotalMinutosAdicionalesNoche,
            0 AS QTotalMinutosZ,
            0 AS QTotalMinutosZNoche,
            0 AS QTotalMinutos800Recibidos,
            0 AS QTotalMinutos900Recibidos,
            0 AS QTotalMinutos900Marcados,
            0 AS QTotalMinutosEmpresaX,
            0 AS QTotalMinutosEmpresaY,
            0 AS QTotalMinutos110,
            0 AS QTotalLlamadas911,
            NULL AS FechaPago,
            0 AS QTotalMinutosFamiliares,
            0 AS QTotalGigasAdicionales,
            0 AS QTotalGigasBase,
            0 AS QTotalMinutos800Marcados
        FROM [dbo].[Contrato] c
        JOIN [dbo].[TipoTarifa] tt ON tt.ID = c.ID_TipoTarifa
        WHERE c.Fecha = @inFechaOperacion
          AND (tt.ID = 7 OR tt.ID = 8);

        ----------------------------DETALLE FACTURA----------------------------------------
        SET @Contador = 1;

        WHILE @Contador <= @MaxContador
        BEGIN
            INSERT INTO [dbo].[DetalleFactura](
                ID_Factura,
                ID_ElementoTipoTarifa,
                Monto,
                ID_Descripcion
            )
            SELECT
                f.Id AS ID_Factura,
                ett.ID AS ID_ElementoTipoTarifa,
                ett.Valor AS Monto,
                @Contador AS ID_Descripcion
            FROM [dbo].[Factura] f
            INNER JOIN [dbo].[Contrato] c ON f.ID_Contrato = c.ID
            INNER JOIN [dbo].[ElementoTipoTarifa] ett ON ett.ID_TipoTarifa = c.ID_TipoTarifa
                                                    AND ett.ID_TipoElemento = @Contador
            WHERE f.FechaFactura = @inFechaOperacion

            SET @Contador = @Contador + 1;
        END

        -----------------------------------------------------------------
        COMMIT TRANSACTION tAC_Fact;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH

    SET NOCOUNT OFF;

END
