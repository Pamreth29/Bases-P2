USE [Telefoneria]
GO

/****** Object:  Table [dbo].[LlamadaNoLocal]    Script Date: 6/6/2024 01:53:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LlamadaNoLocal](
	[ID_Llamadas] [int] NOT NULL,
	[ID_Operador] [int] NOT NULL,
 CONSTRAINT [PK_LlamadaNoLocal] PRIMARY KEY CLUSTERED 
(
	[ID_Llamadas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LlamadaNoLocal]  WITH CHECK ADD  CONSTRAINT [FK_LlamadaNoLocal_Llamadas] FOREIGN KEY([ID_Llamadas])
REFERENCES [dbo].[Llamadas] ([Id])
GO

ALTER TABLE [dbo].[LlamadaNoLocal] CHECK CONSTRAINT [FK_LlamadaNoLocal_Llamadas]
GO

ALTER TABLE [dbo].[LlamadaNoLocal]  WITH CHECK ADD  CONSTRAINT [FK_LlamadaNoLocal_Operador] FOREIGN KEY([ID_Operador])
REFERENCES [dbo].[Operador] ([Id])
GO

ALTER TABLE [dbo].[LlamadaNoLocal] CHECK CONSTRAINT [FK_LlamadaNoLocal_Operador]
GO

