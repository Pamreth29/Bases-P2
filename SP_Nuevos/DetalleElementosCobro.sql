USE [Telefoneria]
GO
/****** Object:  StoredProcedure [dbo].[CargaSubDetalles]    Script Date: 6/5/2024 9:02:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CargaSubDetalles_ElementosCobro]
    @inFechaOperacion AS DATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION tCargaSubDetalles
        --------------- Declaración de variables ---------------
        DECLARE @Fecha_Pago DATE;
		DECLARE @TarifaBasica INT;

        -------------- Inicializacion de variables ---------------
        SET @Fecha_Pago = DATEADD(MONTH, 1, @inFechaOperacion);
		
		-- Insertar detalle Elementos Cobro

		INSERT INTO [dbo].[DetalleElementosCobro](
			[ID_DetalleFactura],
			[TarifaBasica],
			[QMinutosExceso],
			[QFamiliar]
		)
		SELECT 
			df.ID_Facturas AS ID_DetalleFactura,
			CASE 
				WHEN ett.ID_TipoTarifa IN (7, 8) THEN 0
				ELSE ett.Valor
			END AS TarifaBasica,
			0 AS QMinutosExceso,
			0 AS QFamiliar
		FROM 
			[dbo].[DetalleFactura] df
		JOIN 
			[dbo].[Facturas] f ON df.ID_Facturas = f.Id
		JOIN 
			[dbo].[Contrato] c ON f.ID_Contrato = c.Id 
		INNER JOIN 
			ElementoTipoTarifa ett ON ett.ID_TipoTarifa = c.ID_TipoTarifa 
									AND ett.ID_TipoElemento = 1 -- Tarifa base
		WHERE 
			NOT EXISTS (
				SELECT 1 
				FROM [dbo].[DetalleElementosCobro] dec
				WHERE dec.ID_DetalleFactura = df.ID_Facturas
			)

		UNION ALL

		SELECT 
			df.ID_Facturas AS ID_DetalleFactura,
			0 AS TarifaBasica,
			0 AS QMinutosExceso,
			0 AS QFamiliar
		FROM 
			[dbo].[DetalleFactura] df
		JOIN 
			[dbo].[Facturas] f ON df.ID_Facturas = f.Id
		JOIN 
			[dbo].[Contrato] c ON f.ID_Contrato = c.Id AND (c.ID_TipoTarifa = 7 OR c.ID_TipoTarifa = 8)
		WHERE 
			NOT EXISTS (
				SELECT 1 
				FROM [dbo].[DetalleElementosCobro] dec
				WHERE dec.ID_DetalleFactura = df.ID_Facturas
			);






		--select * from contrato where ID_TipoTarifa = 7
		--select * from  facturas where id = 5
		--select * from  detallefactura where ID_Facturas = 5
		

        -----------------------------------------------------------------
        COMMIT TRANSACTION tCargaSubDetalles

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE() AS ErrorMessage
    END CATCH
END
