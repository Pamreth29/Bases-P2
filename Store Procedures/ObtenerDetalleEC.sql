USE [NewTelefoneria]
GO
/****** Object:  StoredProcedure [dbo].[ObtenerDetalleEC]    Script Date: 9/6/2024 12:02:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ObtenerDetalleEC]
    @inNumero VARCHAR(64)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY 
        BEGIN TRANSACTION TObtenerFacturas

        IF LEN(@inNumero) = 11 AND LEFT(@inNumero, 1) = '8'
        BEGIN
            -- Select para números con longitud 11 que empiezan con 8
            SELECT  
                0 AS 'Monto',
                f.QTotalMinutosAdicionales,
                f.QTotalGigasAdicionales,
                f.QTotalMinutosFamiliares,
                (f.QTotalLlamadas911 * ett3.Valor) AS 'TotalCobro911',
                (f.QTotalMinutos110 * ett4.Valor) AS 'TotalCobro110',
                (f.QTotalMinutos900Marcados * ett1.Valor) AS 'TotalCobro900',
                (f.QTotalMinutos800Recibidos * df1.Monto) AS 'TotalCobro800'
            FROM [dbo].[Factura] f
            JOIN [dbo].[Contrato] c ON c.Id = f.ID_Contrato AND c.ID_TipoTarifa = 7
            JOIN [dbo].[ElementoTipoTarifa] ett1 ON ett1.ID_TipoElemento = 9
            JOIN [dbo].[DetalleFactura] df1 ON df1.ID_Factura = f.Id AND df1.ID_Descripcion = 9
            JOIN (SELECT TOP 1 * FROM [dbo].[ElementoTipoTarifa] WHERE ID_TipoElemento = 11) ett3 ON ett3.ID_TipoElemento = 11
            JOIN (SELECT TOP 1 * FROM [dbo].[ElementoTipoTarifa] WHERE ID_TipoElemento = 13) ett4 ON ett4.ID_TipoElemento = 13
            WHERE c.Numero = @inNumero
            ORDER BY f.FechaFactura ASC
        END
        ELSE IF LEN(@inNumero) = 11 AND LEFT(@inNumero, 1) = '9'
        BEGIN
            -- Select para números con longitud 11 que empiezan con 9
            SELECT  
                0 AS 'Monto',
                f.QTotalMinutosAdicionales,
                f.QTotalGigasAdicionales,
                f.QTotalMinutosFamiliares,
                (f.QTotalLlamadas911 * ett3.Valor) AS 'TotalCobro911',
                (f.QTotalMinutos110 * ett4.Valor) AS 'TotalCobro110',
                (f.QTotalMinutos900Marcados * ett1.Valor) AS 'TotalCobro900',
                (f.QTotalMinutos800Recibidos * df1.Monto) AS 'TotalCobro800'
            FROM [dbo].[Factura] f
            JOIN [dbo].[Contrato] c ON c.Id = f.ID_Contrato AND c.ID_TipoTarifa = 8
            JOIN [dbo].[ElementoTipoTarifa] ett1 ON ett1.ID_TipoElemento = 9
            JOIN [dbo].[DetalleFactura] df1 ON df1.ID_Factura = f.Id AND df1.ID_Descripcion = 10
            JOIN (SELECT TOP 1 * FROM [dbo].[ElementoTipoTarifa] WHERE ID_TipoElemento = 11) ett3 ON ett3.ID_TipoElemento = 11
            JOIN (SELECT TOP 1 * FROM [dbo].[ElementoTipoTarifa] WHERE ID_TipoElemento = 13) ett4 ON ett4.ID_TipoElemento = 13
            WHERE c.Numero = @inNumero
            ORDER BY f.FechaFactura ASC
        END
        ELSE
        BEGIN
            -- Select por defecto
            SELECT  
                df1.Monto,
                f.QTotalMinutosAdicionales,
                f.QTotalGigasAdicionales,
                f.QTotalMinutosFamiliares,
                (f.QTotalLlamadas911 * df2.Monto) AS 'TotalCobro911',
                (f.QTotalMinutos110 * df3.Monto) AS 'TotalCobro110',
                (f.QTotalMinutos900Marcados * ett1.Valor) AS 'TotalCobro900',
                0 AS 'TotalCobro800'
            FROM [dbo].[Factura] f
            JOIN [dbo].[Contrato] c ON c.Id = f.ID_Contrato AND c.ID_TipoTarifa < 7
            JOIN [dbo].[DetalleFactura] df1 ON df1.ID_Factura = f.Id AND df1.ID_Descripcion = 1
            JOIN [dbo].[DetalleFactura] df2 ON df2.ID_Factura = f.Id AND df2.ID_Descripcion = 11
            JOIN [dbo].[DetalleFactura] df3 ON df3.ID_Factura = f.Id AND df3.ID_Descripcion = 13
            JOIN [dbo].[ElementoTipoTarifa] ett1 ON ett1.ID_TipoElemento = 9
            JOIN [dbo].[ElementoTipoTarifa] ett2 ON ett2.ID_TipoElemento = 10
            WHERE c.Numero = @inNumero
            ORDER BY f.FechaFactura ASC
        END
        
        COMMIT TRANSACTION TObtenerFacturas
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH

    SET NOCOUNT OFF;

END
