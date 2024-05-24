USE [Proyecto2]
GO

/****** Object:  Table [dbo].[Facturas]    Script Date: 23/5/2024 22:30:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Facturas](
	[ID_Factura] [int] IDENTITY(1,1) NOT NULL,
	[ID_Contrato] [int] NULL,
	[ID_DetallesElementosCobro] [int] NULL,
	[FechaEmision] [date] NULL,
	[FechaPago] [date] NULL,
	[TotalPREiva] [float] NULL,
	[TotalPOSTiva] [float] NULL,
	[TotalFacturado] [float] NULL,
	[MultaPorAtraso] [float] NULL,
	[TotalAPagar] [float] NULL,
	[Estado] [bit] NULL,
	[CostoPorMinuto] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD FOREIGN KEY([ID_Contrato])
REFERENCES [dbo].[NuevoContrato] ([Id])
GO

ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD FOREIGN KEY([ID_DetallesElementosCobro])
REFERENCES [dbo].[DetalleElementosCobro] ([id])
GO

