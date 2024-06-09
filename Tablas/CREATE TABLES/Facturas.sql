USE [Telefoneria]
GO

/****** Object:  Table [dbo].[Facturas]    Script Date: 6/6/2024 01:53:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Facturas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_Contrato] [int] NOT NULL,
	[FechaEmision] [date] NOT NULL,
	[FechaPago] [date] NOT NULL,
	[TotalAPagar] [int] NOT NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_Facturas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD  CONSTRAINT [FK_Facturas_Contrato] FOREIGN KEY([ID_Contrato])
REFERENCES [dbo].[Contrato] ([Id])
GO

ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [FK_Facturas_Contrato]
GO

