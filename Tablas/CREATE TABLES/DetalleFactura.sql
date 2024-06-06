USE [Telefoneria]
GO

/****** Object:  Table [dbo].[DetalleFactura]    Script Date: 6/6/2024 01:52:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleFactura](
	[ID_Facturas] [int] NOT NULL,
	[TotalPreIVA] [int] NOT NULL,
	[TotalPostIVA] [float] NOT NULL,
	[MultaPorAtraso] [int] NOT NULL,
 CONSTRAINT [PK_DetalleFactura] PRIMARY KEY CLUSTERED 
(
	[ID_Facturas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD  CONSTRAINT [FK_DetalleFactura_Facturas] FOREIGN KEY([ID_Facturas])
REFERENCES [dbo].[Facturas] ([Id])
GO

ALTER TABLE [dbo].[DetalleFactura] CHECK CONSTRAINT [FK_DetalleFactura_Facturas]
GO

