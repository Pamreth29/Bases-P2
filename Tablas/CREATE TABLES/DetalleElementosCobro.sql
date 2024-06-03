USE [Proyecto2]
GO

/****** Object:  Table [dbo].[DetalleElementosCobro]    Script Date: 3/6/2024 02:46:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleElementosCobro](
	[ID_DetalleFactura] [int] NOT NULL,
	[ID_ElementoTipoTarifa] [int] NOT NULL,
	[QMinExcesoTarifaBasica] [int] NOT NULL,
	[QMinFamiliares] [int] NOT NULL,
 CONSTRAINT [PK_DetalleElementosCobro] PRIMARY KEY CLUSTERED 
(
	[ID_DetalleFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleElementosCobro]  WITH CHECK ADD  CONSTRAINT [FK_DetalleElementosCobro_DetalleFactura] FOREIGN KEY([ID_DetalleFactura])
REFERENCES [dbo].[DetalleFactura] ([ID_Facturas])
GO

ALTER TABLE [dbo].[DetalleElementosCobro] CHECK CONSTRAINT [FK_DetalleElementosCobro_DetalleFactura]
GO

ALTER TABLE [dbo].[DetalleElementosCobro]  WITH CHECK ADD  CONSTRAINT [FK_DetalleElementosCobro_ElementoTipoTarifa] FOREIGN KEY([ID_ElementoTipoTarifa])
REFERENCES [dbo].[ElementoTipoTarifa] ([Id])
GO

ALTER TABLE [dbo].[DetalleElementosCobro] CHECK CONSTRAINT [FK_DetalleElementosCobro_ElementoTipoTarifa]
GO

