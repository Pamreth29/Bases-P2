USE [Telefoneria]
GO

/****** Object:  Table [dbo].[FacturaXNumeroXDuracionTotal]    Script Date: 6/6/2024 01:53:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FacturaXNumeroXDuracionTotal](
	[ID_Factura] [int] NOT NULL,
	[Numero] [varchar](64) NOT NULL,
	[DuraciónTotal] [int] NOT NULL,
	[MinutosDisponibles] [int] NOT NULL,
	[MinutosExceso] [int] NOT NULL,
	[MinAdicionalDiario] [int] NOT NULL,
	[MinAdicionalNocturno] [int] NOT NULL,
 CONSTRAINT [PK_FacturaXNumeroXDuracionTotal] PRIMARY KEY CLUSTERED 
(
	[ID_Factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FacturaXNumeroXDuracionTotal]  WITH CHECK ADD  CONSTRAINT [FK_FacturaXNumeroXDuracionTotal_Facturas] FOREIGN KEY([ID_Factura])
REFERENCES [dbo].[Facturas] ([Id])
GO

ALTER TABLE [dbo].[FacturaXNumeroXDuracionTotal] CHECK CONSTRAINT [FK_FacturaXNumeroXDuracionTotal_Facturas]
GO

