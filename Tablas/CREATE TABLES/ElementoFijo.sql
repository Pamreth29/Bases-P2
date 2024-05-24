USE [Proyecto2]
GO

/****** Object:  Table [dbo].[ElementoFijo]    Script Date: 23/5/2024 22:31:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ElementoFijo](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[Valor] [int] NOT NULL,
	[IdTipoUnidad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ElementoFijo]  WITH CHECK ADD FOREIGN KEY([IdTipoUnidad])
REFERENCES [dbo].[TipoUnidad] ([Id])
GO

