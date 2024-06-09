USE [NewTelefoneria]
GO

/****** Object:  Table [dbo].[Contrato]    Script Date: 9/6/2024 11:40:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Contrato](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_Cliente] [int] NOT NULL,
	[ID_TipoTarifa] [int] NOT NULL,
	[Numero] [varchar](64) NOT NULL,
	[Fecha] [date] NOT NULL,
 CONSTRAINT [PK_Contrato] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Contrato]  WITH CHECK ADD  CONSTRAINT [FK_Contrato_Clientes] FOREIGN KEY([ID_Cliente])
REFERENCES [dbo].[Clientes] ([Id])
GO

ALTER TABLE [dbo].[Contrato] CHECK CONSTRAINT [FK_Contrato_Clientes]
GO

ALTER TABLE [dbo].[Contrato]  WITH CHECK ADD  CONSTRAINT [FK_Contrato_TipoTarifa] FOREIGN KEY([ID_TipoTarifa])
REFERENCES [dbo].[TipoTarifa] ([Id])
GO

ALTER TABLE [dbo].[Contrato] CHECK CONSTRAINT [FK_Contrato_TipoTarifa]
GO

