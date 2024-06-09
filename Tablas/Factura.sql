USE [NewTelefoneria]
GO

/****** Object:  Table [dbo].[Factura]    Script Date: 9/6/2024 11:41:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Factura](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_Contrato] [int] NOT NULL,
	[FechaFactura] [date] NOT NULL,
	[FechaLimitePago] [date] NULL,
	[FechaPago] [date] NULL,
	[MultaAtrasoPago] [int] NOT NULL,
	[TotalAntesIVA] [int] NOT NULL,
	[MontoIVA] [float] NOT NULL,
	[TotalAPagar] [float] NOT NULL,
	[QTotalMinutosZ] [int] NOT NULL,
	[QTotalMinutosZNoche] [int] NOT NULL,
	[QTotalMinutosAdicionales] [int] NOT NULL,
	[QTotalMinutosAdicionalesNoche] [int] NOT NULL,
	[QTotalMinutosFamiliares] [int] NOT NULL,
	[QTotalGigasBase] [float] NOT NULL,
	[QTotalGigasAdicionales] [float] NOT NULL,
	[QTotalMinutos110] [int] NOT NULL,
	[QTotalLlamadas911] [int] NOT NULL,
	[QTotalMinutosEmpresaX] [int] NOT NULL,
	[QTotalMinutosEmpresaY] [int] NOT NULL,
	[QTotalMinutos800Marcados] [int] NOT NULL,
	[QTotalMinutos900Marcados] [int] NOT NULL,
	[QTotalMinutos800Recibidos] [int] NOT NULL,
	[QTotalMinutos900Recibidos] [int] NOT NULL,
 CONSTRAINT [PK_Factura] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_Contrato] FOREIGN KEY([ID_Contrato])
REFERENCES [dbo].[Contrato] ([Id])
GO

ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [FK_Factura_Contrato]
GO

