USE [Telefoneria]
GO

/****** Object:  Table [dbo].[ElementoTipoTarifa]    Script Date: 6/6/2024 01:52:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ElementoTipoTarifa](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_TipoTarifa] [int] NOT NULL,
	[Valor] [int] NOT NULL,
	[ID_TipoElemento] [int] NOT NULL,
 CONSTRAINT [PK_ElementoTipoTarifa] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ElementoTipoTarifa]  WITH CHECK ADD  CONSTRAINT [fk_ElementoTipoTarifa_TipoElemento] FOREIGN KEY([ID_TipoElemento])
REFERENCES [dbo].[TipoElemento] ([Id])
GO

ALTER TABLE [dbo].[ElementoTipoTarifa] CHECK CONSTRAINT [fk_ElementoTipoTarifa_TipoElemento]
GO

ALTER TABLE [dbo].[ElementoTipoTarifa]  WITH CHECK ADD  CONSTRAINT [FK_ElementoTipoTarifa_TipoTarifa] FOREIGN KEY([ID_TipoTarifa])
REFERENCES [dbo].[TipoTarifa] ([Id])
GO

ALTER TABLE [dbo].[ElementoTipoTarifa] CHECK CONSTRAINT [FK_ElementoTipoTarifa_TipoTarifa]
GO

