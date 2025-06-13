USE [NewTelefoneria]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ActualizarDatosFactura]
    @inFechaOperacion AS DATE
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION TActualizarDatosFactura

        -- Actualización de QTotalMinutosAdicionales
        UPDATE f
        SET 
            f.QTotalMinutosAdicionales = CASE 
                                            WHEN ISNULL((SELECT SUM(dl.Duracion) 
                                                          FROM [dbo].[DetalleLlamadas] dl
                                                          WHERE dl.ID_DetalleFactura = df.ID_Factura 
                                                          AND (
                                                              (dl.ID_TipoMinutos1 = 1 AND dl.ID_TipoMinutos2 IS NULL) 
                                                              OR (dl.ID_TipoMinutos1 = 2 AND dl.ID_TipoMinutos2 = 1)
                                                          )), 0) > 
                                                  (SELECT ett2.Valor 
                                                   FROM [dbo].[ElementoTipoTarifa] ett2 
                                                   WHERE ett2.ID_TipoTarifa = c.ID_TipoTarifa 
                                                   AND ett2.ID_TipoElemento = 2) 
                                            THEN ISNULL((SELECT SUM(dl.Duracion) 
                                                          FROM [dbo].[DetalleLlamadas] dl
                                                          WHERE dl.ID_DetalleFactura = df.ID_Factura 
                                                          AND (
                                                              (dl.ID_TipoMinutos1 = 1 AND dl.ID_TipoMinutos2 IS NULL) 
                                                              OR (dl.ID_TipoMinutos1 = 2 AND dl.ID_TipoMinutos2 = 1)
                                                          )), 0) - 
                                                  (SELECT ett2.Valor 
                                                   FROM [dbo].[ElementoTipoTarifa] ett2 
                                                   WHERE ett2.ID_TipoTarifa = c.ID_TipoTarifa 
                                                   AND ett2.ID_TipoElemento = 2)
                                            ELSE 0
                                        END
        FROM 
            [dbo].[Factura] f
        JOIN 
            [dbo].[DetalleFactura] df ON f.Id = df.ID_Factura
        JOIN 
            [dbo].[Contrato] c ON f.ID_Contrato = c.Id
        JOIN 
            [dbo].[ElementoTipoTarifa] ett ON ett.ID_TipoTarifa = c.ID_TipoTarifa 
                                            AND ett.ID_TipoElemento = 1
        JOIN 
            [dbo].[ElementoTipoTarifa] ett2 ON ett2.ID_TipoTarifa = c.ID_TipoTarifa 
                                            AND ett2.ID_TipoElemento = 2;

        -- Actualización de otros campos de la Factura
        UPDATE f
        SET
            f.QTotalMinutosZ = ISNULL((SELECT SUM(dl.Duracion) 
                                       FROM [dbo].[DetalleLlamadas] dl
                                       WHERE dl.ID_DetalleFactura = df.ID_Factura 
                                       AND dl.ID_TipoMinutos1 IN (1)),0),
            f.QTotalMinutosZNoche = ISNULL((SELECT SUM(dl.Duracion) 
                                            FROM [dbo].[DetalleLlamadas] dl
                                            WHERE dl.ID_DetalleFactura = df.ID_Factura 
                                            AND dl.ID_TipoMinutos1 IN (2)), 0),
            f.QTotalGigasBase = ISNULL((SELECT SUM(du.TotalQGigasBase)
                                        FROM [dbo].[DetalleUsoDatos] du
                                        WHERE du.ID_DetalleFactura = df.ID_Factura), 0),
            f.QTotalGigasAdicionales = ISNULL((SELECT SUM(du.TotalQGigasAdicional)
                                               FROM [dbo].[DetalleUsoDatos] du
                                               WHERE du.ID_DetalleFactura = df.ID_Factura), 0),
            f.QTotalLlamadas911 = ISNULL((SELECT COUNT(*)
                                          FROM [dbo].[DetalleLlamadas] dl
                                          WHERE dl.ID_DetalleFactura = df.ID_Factura
                                          AND dl.ID_TipoMinutos1 = 7), 0),
            f.QTotalMinutos110 = ISNULL((SELECT SUM(dl.Duracion)
                                         FROM [dbo].[DetalleLlamadas] dl
                                         WHERE dl.ID_DetalleFactura = df.ID_Factura
                                         AND dl.ID_TipoMinutos1 = 8), 0),
            f.QTotalMinutosFamiliares = ISNULL((SELECT SUM(dl.Duracion)
                                                FROM [dbo].[DetalleLlamadas] dl
                                                WHERE dl.ID_DetalleFactura = df.ID_Factura
                                                AND dl.ID_TipoMinutos1 = 9), 0), 
            f.QTotalMinutosEmpresaX = ISNULL((SELECT SUM(dl.Duracion)
                                              FROM [dbo].[DetalleLlamadas] dl
                                              WHERE dl.ID_DetalleFactura = df.ID_Factura
                                              AND dl.ID_TipoMinutos1 = 3), 0),
            f.QTotalMinutosEmpresaY = ISNULL((SELECT SUM(dl.Duracion)
                                              FROM [dbo].[DetalleLlamadas] dl
                                              WHERE dl.ID_DetalleFactura = df.ID_Factura
                                              AND dl.ID_TipoMinutos1 = 4), 0),
            f.QTotalMinutos800Recibidos = ISNULL((
                                                SELECT CASE 
                                                    WHEN EXISTS (
                                                        SELECT 1
                                                        FROM Contrato c 
                                                        WHERE c.Id = f.ID_Contrato 
                                                        AND c.ID_TipoTarifa IN (1, 2, 3, 4, 5, 6, 8)
                                                    ) THEN 0
                                                    ELSE (
                                                        SELECT ISNULL(SUM(DATEDIFF(MINUTE, CONVERT(DATETIME, l.FechaHora_Inicio), CONVERT(DATETIME, l.FechaHora_Fin))), 0)
                                                        FROM Llamadas l
                                                        WHERE l.NumeroA = c.Numero
                                                        AND l.FechaHora_Inicio >= f.FechaFactura 
                                                        AND l.FechaHora_Inicio < DATEADD(MONTH, 1, f.FechaFactura)
                                                    )
                                                END
                                            ), 0),
            f.QTotalMinutos900Recibidos = ISNULL((
                                                SELECT CASE 
                                                    WHEN EXISTS (
                                                        SELECT 1
                                                        FROM Contrato c 
                                                        WHERE c.Id = f.ID_Contrato 
                                                        AND c.ID_TipoTarifa IN (1, 2, 3, 4, 5, 6, 7)
                                                    ) THEN 0
                                                    ELSE (
                                                        SELECT ISNULL(SUM(DATEDIFF(MINUTE, CONVERT(DATETIME, l.FechaHora_Inicio), CONVERT(DATETIME, l.FechaHora_Fin))), 0)
                                                        FROM Llamadas l
                                                        WHERE l.NumeroA = c.Numero
                                                        AND l.FechaHora_Inicio >= f.FechaFactura 
                                                        AND l.FechaHora_Inicio < DATEADD(MONTH, 1, f.FechaFactura)
                                                    )
                                                END
                                            ), 0),
            f.QTotalMinutos800Marcados = ISNULL((SELECT SUM(dl.Duracion)
                                                 FROM [dbo].[DetalleLlamadas] dl
                                                 WHERE dl.ID_DetalleFactura = df.ID_Factura
                                                 AND dl.ID_TipoMinutos1 = 5), 0),
            f.QTotalMinutos900Marcados = ISNULL((SELECT SUM(dl.Duracion) 
                                                 FROM [dbo].[DetalleLlamadas] dl
                                                 WHERE dl.ID_DetalleFactura = df.ID_Factura
                                                 AND dl.ID_TipoMinutos1 = 6), 0)
        FROM 
            [dbo].[Factura] f
        JOIN 
            [dbo].[DetalleFactura] df ON f.Id = df.ID_Factura
        JOIN 
            [dbo].[Contrato] c ON f.ID_Contrato = c.Id;

        -- Actualización de MultaAtrasoPago
        UPDATE f2
        SET MultaAtrasoPago = ett.Valor
        FROM Factura f2
        JOIN Factura f1 ON f2.ID_Contrato = f1.ID_Contrato
        JOIN Contrato c ON c.Id = f1.ID_Contrato 
        JOIN ElementoTipoTarifa ett ON ett.ID_TipoTarifa = c.ID_TipoTarifa 
            AND ett.ID_TipoElemento = 8
        WHERE c.ID_TipoTarifa < 7
        AND f1.FechaPago IS NULL
        AND f2.FechaPago IS NULL
        AND f1.FechaLimitePago < @inFechaOperacion
        AND DATEADD(MONTH, 1, f1.FechaFactura) = f2.FechaFactura;

        -- Nueva actualización para TotalAntesIVA, MontoIVA y TotalAPagar
        UPDATE f
        SET 
            f.TotalAntesIVA = 
                ISNULL((SELECT df.Monto FROM DetalleFactura df WHERE df.ID_Factura = f.Id AND df.ID_Descripcion = 1), 0) +
                ISNULL((SELECT f.QTotalMinutosAdicionales * df.Monto FROM DetalleFactura df WHERE df.ID_Factura = f.Id AND df.ID_Descripcion = 3), 0) +
                ISNULL((SELECT f.QTotalMinutosAdicionalesNoche * df.Monto FROM DetalleFactura df WHERE df.ID_Factura = f.Id AND df.ID_Descripcion = 4), 0) +
                ISNULL((SELECT f.QTotalMinutos800Recibidos * df.Monto FROM DetalleFactura df WHERE df.ID_Factura = f.Id AND df.ID_Descripcion = 9), 0) +
                ISNULL((SELECT f.QTotalMinutos900Marcados * df.Monto FROM DetalleFactura df WHERE df.ID_Factura = f.Id AND df.ID_Descripcion = 10), 0) +
                ISNULL((SELECT f.QTotalLlamadas911 * df.Monto FROM DetalleFactura df WHERE df.ID_Factura = f.Id AND df.ID_Descripcion = 11), 0) +
                ISNULL((SELECT f.QTotalMinutos110 * df.Monto FROM DetalleFactura df WHERE df.ID_Factura = f.Id AND df.ID_Descripcion = 13), 0) +
                ISNULL((SELECT f.QTotalGigasAdicionales * df.Monto FROM DetalleFactura df WHERE df.ID_Factura = f.Id AND df.ID_Descripcion = 6), 0) +
                ISNULL((SELECT f.QTotalMinutosEmpresaX * df.Monto FROM DetalleFactura df WHERE df.ID_Factura = f.Id AND df.ID_Descripcion = 14), 0) +
                ISNULL((SELECT f.QTotalMinutosEmpresaY * df.Monto FROM DetalleFactura df WHERE df.ID_Factura = f.Id AND df.ID_Descripcion = 15), 0) +
                f.MultaAtrasoPago,

            f.MontoIVA = ISNULL((SELECT df.Monto FROM DetalleFactura df WHERE df.ID_Factura = f.Id AND df.ID_Descripcion = 12), 0),

            f.TotalAPagar = f.TotalAntesIVA + (f.TotalAntesIVA * f.MontoIVA / 100)
        FROM [dbo].[Factura] f;

        COMMIT TRANSACTION TActualizarDatosFactura

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE() AS ErrorMessage
    END CATCH

    SET NOCOUNT OFF;
END
