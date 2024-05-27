USE [Proyecto2]
GO

/****** Object:  Table [dbo].[TipoTarifaXTipoElemento]    Script Date: 26/5/2024 23:56:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TipoTarifaXTipoElemento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_TipoTarifa] [int] NOT NULL,
	[ID_TipoElemento] [int] NOT NULL,
	[Valor] [float] NOT NULL,
 CONSTRAINT [PK_TipoTarifaXTipoElemento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TipoTarifaXTipoElemento]  WITH CHECK ADD  CONSTRAINT [FK_TipoTarifaXTipoElemento_TipoElemento] FOREIGN KEY([ID_TipoElemento])
REFERENCES [dbo].[TipoElemento] ([Id])
GO

ALTER TABLE [dbo].[TipoTarifaXTipoElemento] CHECK CONSTRAINT [FK_TipoTarifaXTipoElemento_TipoElemento]
GO

ALTER TABLE [dbo].[TipoTarifaXTipoElemento]  WITH CHECK ADD  CONSTRAINT [FK_TipoTarifaXTipoElemento_TipoTarifa] FOREIGN KEY([ID_TipoTarifa])
REFERENCES [dbo].[TipoTarifa] ([Id])
GO

ALTER TABLE [dbo].[TipoTarifaXTipoElemento] CHECK CONSTRAINT [FK_TipoTarifaXTipoElemento_TipoTarifa]
GO

