USE [Telefoneria]
GO

/****** Object:  Table [dbo].[DetalleUsoDatos]    Script Date: 6/6/2024 01:52:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleUsoDatos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_DetalleFactura] [int] NOT NULL,
	[TotalQGigasBase] [float] NOT NULL,
	[TotalQGigasAdicional] [float] NOT NULL,
	[TotalQGigas] [float] NOT NULL,
 CONSTRAINT [PK_DetalleUsoDatos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleUsoDatos]  WITH CHECK ADD  CONSTRAINT [FK_DetalleUsoDatos_DetalleFactura] FOREIGN KEY([ID_DetalleFactura])
REFERENCES [dbo].[DetalleFactura] ([ID_Facturas])
GO

ALTER TABLE [dbo].[DetalleUsoDatos] CHECK CONSTRAINT [FK_DetalleUsoDatos_DetalleFactura]
GO

