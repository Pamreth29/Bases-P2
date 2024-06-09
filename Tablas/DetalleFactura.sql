USE [NewTelefoneria]
GO

/****** Object:  Table [dbo].[DetalleFactura]    Script Date: 9/6/2024 11:40:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleFactura](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_Factura] [int] NOT NULL,
	[ID_ElementoTipoTarifa] [int] NOT NULL,
	[Monto] [int] NOT NULL,
	[ID_Descripcion] [int] NOT NULL,
 CONSTRAINT [PK_DetalleFactura] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD  CONSTRAINT [FK_DetalleFactura_Descripcion] FOREIGN KEY([ID_Descripcion])
REFERENCES [dbo].[Descripcion] ([Id])
GO

ALTER TABLE [dbo].[DetalleFactura] CHECK CONSTRAINT [FK_DetalleFactura_Descripcion]
GO

ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD  CONSTRAINT [FK_DetalleFactura_ElementoTipoTarifa] FOREIGN KEY([ID_ElementoTipoTarifa])
REFERENCES [dbo].[ElementoTipoTarifa] ([Id])
GO

ALTER TABLE [dbo].[DetalleFactura] CHECK CONSTRAINT [FK_DetalleFactura_ElementoTipoTarifa]
GO

ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD  CONSTRAINT [FK_DetalleFactura_Factura] FOREIGN KEY([ID_Factura])
REFERENCES [dbo].[Factura] ([Id])
GO

ALTER TABLE [dbo].[DetalleFactura] CHECK CONSTRAINT [FK_DetalleFactura_Factura]
GO

