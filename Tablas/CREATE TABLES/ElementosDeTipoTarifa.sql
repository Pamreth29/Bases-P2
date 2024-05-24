USE [Proyecto2]
GO

/****** Object:  Table [dbo].[ElementoDeTipoTarifa]    Script Date: 23/5/2024 22:31:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ElementoDeTipoTarifa](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idTipoTarifa] [int] NULL,
	[IdTipoElemento] [int] NULL,
	[Valor] [int] NOT NULL,
	[IdTipoUnidad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ElementoDeTipoTarifa]  WITH CHECK ADD FOREIGN KEY([idTipoTarifa])
REFERENCES [dbo].[TipoTarifa] ([Id])
GO

ALTER TABLE [dbo].[ElementoDeTipoTarifa]  WITH CHECK ADD FOREIGN KEY([IdTipoElemento])
REFERENCES [dbo].[TipoElemento] ([Id])
GO

ALTER TABLE [dbo].[ElementoDeTipoTarifa]  WITH CHECK ADD FOREIGN KEY([IdTipoUnidad])
REFERENCES [dbo].[TipoUnidad] ([Id])
GO

