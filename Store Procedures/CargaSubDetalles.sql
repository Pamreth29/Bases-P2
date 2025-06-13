USE [NewTelefoneria]
GO
/****** Object:  StoredProcedure [dbo].[CargaSubDetalles]    Script Date: 9/6/2024 12:01:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CargaSubDetalles]
    @inFechaOperacion AS DATE
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION tCargaSubDetalles

        ---------- Inserción de nuevos registros ----------------
        ----DetalleUsoDatos
	    
        ----Actualizar filas existentes en DetalleUsoDatos
        UPDATE du
        SET 
            du.TotalQGigasBase = CASE 
                                    WHEN du.TotalQGigasBase + u.QGigas <= ett.Valor THEN du.TotalQGigasBase + u.QGigas
                                    ELSE ett.Valor
                                 END,
            du.TotalQGigasAdicional = CASE 
                                        WHEN du.TotalQGigasBase + u.QGigas > ett.Valor THEN ROUND(
                                            du.TotalQGigasAdicional + (u.QGigas - ett.Valor + du.TotalQGigasBase), 3
                                        )
                                        ELSE du.TotalQGigasAdicional
                                     END,
            du.TotalQGigas = CASE 
                                WHEN du.TotalQGigasBase + u.QGigas <= ett.Valor THEN du.TotalQGigasBase + u.QGigas + du.TotalQGigasAdicional
                                ELSE ett.Valor + du.TotalQGigasAdicional + (u.QGigas - ett.Valor + du.TotalQGigasBase)
                             END
        FROM 
            [dbo].[DetalleUsoDatos] du
        JOIN 
            [dbo].[DetalleFactura] df ON du.ID_DetalleFactura = df.ID_Factura
        JOIN 
            [dbo].[Factura] f ON df.ID_Factura = f.Id
        JOIN 
            [dbo].[Contrato] c ON f.ID_Contrato = c.Id
        JOIN 
            [dbo].[UsoDatos] u ON c.Numero = u.Numero
        JOIN 
            [dbo].[ElementoTipoTarifa] ett ON c.ID_TipoTarifa = ett.Id_TipoTarifa AND ett.ID_TipoElemento = 5
        WHERE 
            u.Fecha = @inFechaOperacion AND
            u.Numero = c.Numero AND
            u.Fecha >= f.FechaFactura AND 
            u.Fecha <  DATEADD(MONTH, 1, f.FechaFactura);

        -- Insertar nuevas filas en DetalleUsoDatos si no existen
        INSERT INTO [dbo].[DetalleUsoDatos] (
            [ID_DetalleFactura],
            [TotalQGigasBase],
            [TotalQGigasAdicional],
            [TotalQGigas]
        )
        SELECT DISTINCT
            df.ID_Factura AS ID_DetalleFactura,
            u.QGigas AS TotalQGigasBase,
            0 AS TotalQGigasAdicional,
            u.QGigas AS TotalQGigas
        FROM 
            [dbo].[DetalleFactura] df
        JOIN 
            [dbo].[Factura] f ON df.ID_Factura = f.Id
        JOIN 
            [dbo].[Contrato] c ON f.ID_Contrato = c.Id
        JOIN 
            [dbo].[UsoDatos] u ON c.Numero = u.Numero
        WHERE u.Fecha >= f.FechaFactura
          AND u.Fecha <  DATEADD(MONTH, 1, f.FechaFactura)
          AND NOT EXISTS (
              SELECT 1 
              FROM [dbo].[DetalleUsoDatos] dud
              WHERE dud.ID_DetalleFactura = df.ID_Factura
          )

        ----------------------Detalle Llamadas----------------------

        INSERT INTO [dbo].[DetalleLlamadas] (
            [ID_DetalleFactura],
            [ID_Llamada],
            [ID_TipoMinutos1],
            [ID_TipoMinutos2],
            [Duracion]
        )
        SELECT DISTINCT
            df.ID_Factura AS ID_DetalleFactura,
            l.Id AS ID_Llamada,
            CASE 
                WHEN 
                    CASE
                        WHEN EXISTS (
                            SELECT 1
                            FROM RelacionFamiliar rf
                            JOIN Contrato c2 ON rf.ID_Cliente1 = c2.ID_Cliente OR rf.ID_Cliente2 = c2.ID_Cliente
                            WHERE c2.Numero = l.NumeroA
                        ) THEN 1
                        ELSE 0
                    END = 1 
                THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'MinutosFamiliar')
                WHEN CONVERT(time, l.FechaHora_Inicio) >= '23:00:00' OR CONVERT(time, l.FechaHora_Inicio) < '05:00:00' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'MinutosNocturnos')
                WHEN LEN(l.NumeroA) = 8  AND LEFT(l.NumeroA, 1) = '8' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'MinutosBase')
                WHEN LEN(l.NumeroA) = 8  AND LEFT(l.NumeroA, 1) = '7' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'MinutosEmpresaX')
                WHEN LEN(l.NumeroA) = 8  AND LEFT(l.NumeroA, 1) = '6' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'MinutosEmpresaY')
                WHEN LEN(l.NumeroA) = 11 AND LEFT(l.NumeroA, 1) = '8' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'Minutos800')
                WHEN LEN(l.NumeroA) = 11 AND LEFT(l.NumeroA, 1) = '9' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'Minutos900')
                WHEN LEN(l.NumeroA) = 3  AND LEFT(l.NumeroA, 1) = '9' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'Minutos911')
                WHEN LEN(l.NumeroA) = 3  AND LEFT(l.NumeroA, 1) = '1' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'Minutos110')
                ELSE 0
            END AS ID_TipoMinutos1,
            CASE
                WHEN 
                    CASE
                        WHEN EXISTS (
                            SELECT 1
                            FROM RelacionFamiliar rf
                            JOIN Contrato c2 ON rf.ID_Cliente1 = c2.ID_Cliente OR rf.ID_Cliente2 = c2.ID_Cliente
                            WHERE c2.Numero = l.NumeroA
                        ) THEN 1
                        ELSE 0
                    END = 1 AND (CONVERT(time, l.FechaHora_Inicio) >= '23:00:00' OR CONVERT(time, l.FechaHora_Inicio) < '05:00:00') 
                THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'MinutosNocturnos')
                WHEN 
                    CASE
                        WHEN EXISTS (
                            SELECT 1
                            FROM RelacionFamiliar rf
                            JOIN Contrato c2 ON rf.ID_Cliente1 = c2.ID_Cliente OR rf.ID_Cliente2 = c2.ID_Cliente
                            WHERE c2.Numero = l.NumeroA
                        ) THEN 0
                        ELSE 1
                    END = 1 AND (CONVERT(time, l.FechaHora_Inicio) >= '23:00:00' OR CONVERT(time, l.FechaHora_Inicio) < '05:00:00') 
                THEN 
                    CASE
                        WHEN LEN(l.NumeroA) = 8  AND LEFT(l.NumeroA, 1) = '8' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'MinutosBase')
                        WHEN LEN(l.NumeroA) = 8  AND LEFT(l.NumeroA, 1) = '7' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'MinutosEmpresaX')
                        WHEN LEN(l.NumeroA) = 8  AND LEFT(l.NumeroA, 1) = '6' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'MinutosEmpresaY')
                        WHEN LEN(l.NumeroA) = 11 AND LEFT(l.NumeroA, 1) = '8' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'Minutos800')
                        WHEN LEN(l.NumeroA) = 11 AND LEFT(l.NumeroA, 1) = '9' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'Minutos900')
                        WHEN LEN(l.NumeroA) = 3  AND LEFT(l.NumeroA, 1) = '9' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'Minutos911')
                        WHEN LEN(l.NumeroA) = 3  AND LEFT(l.NumeroA, 1) = '1' THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'Minutos110')
                        ELSE NULL
                    END
                WHEN 
                    CASE
                        WHEN EXISTS (
                            SELECT 1
                            FROM RelacionFamiliar rf
                            JOIN Contrato c2 ON rf.ID_Cliente1 = c2.ID_Cliente OR rf.ID_Cliente2 = c2.ID_Cliente
                            WHERE c2.Numero = l.NumeroA
                        ) THEN 1
                        ELSE 0
                    END = 1 AND (CONVERT(time, l.FechaHora_Inicio) < '23:00:00' AND CONVERT(time, l.FechaHora_Inicio) >= '05:00:00') AND LEN(l.NumeroA) = 8 AND LEFT(l.NumeroA, 1) = '8' 
                THEN (SELECT Id FROM [dbo].[TipoMinutos] WHERE TipoMinuto = 'MinutosBase')
                ELSE NULL
            END AS ID_TipoMinutos2,
            DATEDIFF(MINUTE, CONVERT(DATETIME, l.FechaHora_Inicio), CONVERT(DATETIME, l.FechaHora_Fin)) AS Duracion
        FROM 
            [dbo].[DetalleFactura] df
        JOIN 
            [dbo].[Factura] f ON df.ID_Factura = f.Id
        JOIN 
            [dbo].[Contrato] c ON f.ID_Contrato = c.Id
		JOIN 
			[dbo].[Llamadas] l ON c.Numero = l.NumeroDe
		WHERE 
			CONVERT(DATE, l.FechaHora_Inicio) = @inFechaOperacion

		-------------------------------------------------------------------------------------------------
        COMMIT TRANSACTION tCargaSubDetalles

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE() AS ErrorMessage
    END CATCH

	SET NOCOUNT OFF;
END
