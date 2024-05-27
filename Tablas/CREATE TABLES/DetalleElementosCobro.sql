USE [Proyecto2]
GO

/****** Object:  Table [dbo].[DetalleElementosCobro]    Script Date: 26/5/2024 23:54:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleElementosCobro](
	[ID_DetalleFactura] [int] NOT NULL,
	[ID_TipoTarifaXTipoElemento] [int] NOT NULL,
	[CantMinExcesoTarifaBasica] [int] NOT NULL,
	[CantGigasExcesoTarifaBasica] [float] NOT NULL,
	[CantiMinFamiliares] [int] NOT NULL,
 CONSTRAINT [PK_DetalleElementosCobro] PRIMARY KEY CLUSTERED 
(
	[ID_DetalleFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleElementosCobro]  WITH CHECK ADD  CONSTRAINT [FK_DetalleElementosCobro_DetalleFactura] FOREIGN KEY([ID_DetalleFactura])
REFERENCES [dbo].[DetalleFactura] ([Id])
GO

ALTER TABLE [dbo].[DetalleElementosCobro] CHECK CONSTRAINT [FK_DetalleElementosCobro_DetalleFactura]
GO

