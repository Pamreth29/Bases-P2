USE [NewTelefoneria]
GO

/****** Object:  Table [dbo].[TipoElementoFijo]    Script Date: 9/6/2024 11:42:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TipoElementoFijo](
	[ID_TipoElemento] [int] NOT NULL,
	[Valor] [int] NOT NULL,
 CONSTRAINT [PK_TipoElementoFijo] PRIMARY KEY CLUSTERED 
(
	[ID_TipoElemento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TipoElementoFijo]  WITH CHECK ADD  CONSTRAINT [FK_TipoElementoFijo_TipoElemento] FOREIGN KEY([ID_TipoElemento])
REFERENCES [dbo].[TipoElemento] ([Id])
GO

ALTER TABLE [dbo].[TipoElementoFijo] CHECK CONSTRAINT [FK_TipoElementoFijo_TipoElemento]
GO

