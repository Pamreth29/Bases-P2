USE [NewTelefoneria]
GO

/****** Object:  Table [dbo].[TipoElemento]    Script Date: 9/6/2024 11:42:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TipoElemento](
	[Id] [int] NOT NULL,
	[ID_TipoUnidad] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[EsFijo] [bit] NOT NULL,
 CONSTRAINT [PK_TipoElemento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TipoElemento]  WITH CHECK ADD  CONSTRAINT [FK_TipoElemento_TipoUnidad] FOREIGN KEY([ID_TipoUnidad])
REFERENCES [dbo].[TipoUnidad] ([Id])
GO

ALTER TABLE [dbo].[TipoElemento] CHECK CONSTRAINT [FK_TipoElemento_TipoUnidad]
GO

