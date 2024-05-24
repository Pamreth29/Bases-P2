USE [Proyecto2]
GO

/****** Object:  Table [dbo].[DetalleFactura]    Script Date: 23/5/2024 22:31:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleFactura](
	[ID] [int] NOT NULL,
	[Facturas] [int] NULL,
	[Monto] [varchar](255) NULL,
	[DetalleElementosCobro] [int] NULL,
	[DetalleLlamada] [int] NULL,
	[ID_UsoDatos] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD FOREIGN KEY([DetalleElementosCobro])
REFERENCES [dbo].[DetalleElementosCobro] ([id])
GO

ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD FOREIGN KEY([DetalleLlamada])
REFERENCES [dbo].[DetalleLlamada] ([ID_DetalleElementosCobro])
GO

ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD FOREIGN KEY([Facturas])
REFERENCES [dbo].[Facturas] ([ID_Factura])
GO

ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD FOREIGN KEY([ID_UsoDatos])
REFERENCES [dbo].[DetalleUsoDatos] ([ID_DetalleElementosCobro])
GO

