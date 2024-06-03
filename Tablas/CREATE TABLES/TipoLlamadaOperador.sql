USE [Proyecto2]
GO

/****** Object:  Table [dbo].[TipoLlamadaOperador]    Script Date: 3/6/2024 02:49:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TipoLlamadaOperador](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_LlamadaNoLocal] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
 CONSTRAINT [PK_TipoLlamadaOperador] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TipoLlamadaOperador]  WITH CHECK ADD  CONSTRAINT [FK_TipoLlamadaOperador_LlamadaNoLocal] FOREIGN KEY([ID_LlamadaNoLocal])
REFERENCES [dbo].[LlamadaNoLocal] ([ID_Llamadas])
GO

ALTER TABLE [dbo].[TipoLlamadaOperador] CHECK CONSTRAINT [FK_TipoLlamadaOperador_LlamadaNoLocal]
GO

