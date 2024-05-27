USE [Proyecto2]
GO

/****** Object:  Table [dbo].[DetalleUsoDatos]    Script Date: 26/5/2024 23:55:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleUsoDatos](
	[ID_DetalleFactura] [int] NOT NULL,
	[ID_UsoDatos] [int] NOT NULL,
	[QGigas] [float] NOT NULL,
 CONSTRAINT [PK_DetalleUsoDatos] PRIMARY KEY CLUSTERED 
(
	[ID_DetalleFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleUsoDatos]  WITH CHECK ADD  CONSTRAINT [FK_DetalleUsoDatos_DetalleFactura] FOREIGN KEY([ID_DetalleFactura])
REFERENCES [dbo].[DetalleFactura] ([Id])
GO

ALTER TABLE [dbo].[DetalleUsoDatos] CHECK CONSTRAINT [FK_DetalleUsoDatos_DetalleFactura]
GO

ALTER TABLE [dbo].[DetalleUsoDatos]  WITH CHECK ADD  CONSTRAINT [FK_DetalleUsoDatos_UsoDatos] FOREIGN KEY([ID_UsoDatos])
REFERENCES [dbo].[UsoDatos] ([Id])
GO

ALTER TABLE [dbo].[DetalleUsoDatos] CHECK CONSTRAINT [FK_DetalleUsoDatos_UsoDatos]
GO

