USE [NewTelefoneria]
GO

/****** Object:  Table [dbo].[DetalleLlamadaNoLocal]    Script Date: 9/6/2024 11:41:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleLlamadaNoLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_LlamadaNoLocal] [int] NOT NULL,
	[ID_TipoMinuto] [int] NOT NULL,
	[Duracion] [int] NOT NULL,
 CONSTRAINT [PK_DetalleLlamadaNoLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleLlamadaNoLocal]  WITH CHECK ADD  CONSTRAINT [FK_DetalleLlamadaNoLocal_LlamadaNoLocal] FOREIGN KEY([ID_LlamadaNoLocal])
REFERENCES [dbo].[LlamadaNoLocal] ([ID_Llamadas])
GO

ALTER TABLE [dbo].[DetalleLlamadaNoLocal] CHECK CONSTRAINT [FK_DetalleLlamadaNoLocal_LlamadaNoLocal]
GO

ALTER TABLE [dbo].[DetalleLlamadaNoLocal]  WITH CHECK ADD  CONSTRAINT [FK_DetalleLlamadaNoLocal_TipoMinutos] FOREIGN KEY([ID_TipoMinuto])
REFERENCES [dbo].[TipoMinutos] ([Id])
GO

ALTER TABLE [dbo].[DetalleLlamadaNoLocal] CHECK CONSTRAINT [FK_DetalleLlamadaNoLocal_TipoMinutos]
GO

