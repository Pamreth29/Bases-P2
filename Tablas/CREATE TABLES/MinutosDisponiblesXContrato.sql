USE [Telefoneria]
GO

/****** Object:  Table [dbo].[MinutosDisponiblesXContrato]    Script Date: 6/6/2024 01:54:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MinutosDisponiblesXContrato](
	[ID_Contrato] [int] NOT NULL,
	[MinutosDisponibles] [int] NOT NULL,
 CONSTRAINT [PK_MinutosDisponiblesXContrato] PRIMARY KEY CLUSTERED 
(
	[ID_Contrato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MinutosDisponiblesXContrato]  WITH CHECK ADD  CONSTRAINT [FK_MinutosDisponiblesXContrato_Contrato] FOREIGN KEY([ID_Contrato])
REFERENCES [dbo].[Contrato] ([Id])
GO

ALTER TABLE [dbo].[MinutosDisponiblesXContrato] CHECK CONSTRAINT [FK_MinutosDisponiblesXContrato_Contrato]
GO

