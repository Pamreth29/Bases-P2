USE [Telefoneria]
GO

/****** Object:  Table [dbo].[DetalleElementosCobro]    Script Date: 6/6/2024 01:52:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleElementosCobro](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_DetalleFactura] [int] NOT NULL,
	[TarifaBasica] [int] NOT NULL,
	[QMinutosExceso] [int] NOT NULL,
	[QFamiliar] [int] NOT NULL,
 CONSTRAINT [PK_DetalleElementosCobro] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleElementosCobro]  WITH CHECK ADD  CONSTRAINT [FK_DetalleElementosCobro_DetalleFactura] FOREIGN KEY([ID_DetalleFactura])
REFERENCES [dbo].[DetalleFactura] ([ID_Facturas])
GO

ALTER TABLE [dbo].[DetalleElementosCobro] CHECK CONSTRAINT [FK_DetalleElementosCobro_DetalleFactura]
GO

