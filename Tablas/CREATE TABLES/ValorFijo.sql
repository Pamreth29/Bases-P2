USE [Proyecto2]
GO

/****** Object:  Table [dbo].[ValorFijo]    Script Date: 26/5/2024 23:57:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ValorFijo](
	[ID_TipoElemento] [int] NOT NULL,
	[Valor] [int] NOT NULL,
 CONSTRAINT [PK_ValorFijo] PRIMARY KEY CLUSTERED 
(
	[ID_TipoElemento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ValorFijo]  WITH CHECK ADD  CONSTRAINT [FK_ValorFijo_TipoElemento] FOREIGN KEY([ID_TipoElemento])
REFERENCES [dbo].[TipoElemento] ([Id])
GO

ALTER TABLE [dbo].[ValorFijo] CHECK CONSTRAINT [FK_ValorFijo_TipoElemento]
GO

