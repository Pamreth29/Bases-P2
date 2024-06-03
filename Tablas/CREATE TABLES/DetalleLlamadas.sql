USE [Proyecto2]
GO

/****** Object:  Table [dbo].[DetalleLlamadas]    Script Date: 3/6/2024 02:47:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleLlamadas](
	[ID_DetalleFactura] [int] NOT NULL,
	[TotalMinutosBase] [int] NOT NULL,
	[TotalMinutosAdicional] [int] NOT NULL,
	[TotalMinutosNocturnos] [int] NOT NULL,
	[TotalMinutos800] [int] NOT NULL,
	[TotalMinutos900] [int] NOT NULL,
	[TotalMinutosEmpresaX] [int] NOT NULL,
	[TotalMinutosEmpresaY] [int] NOT NULL,
	[TotalMinutosNocturnosX] [int] NOT NULL,
	[TotalMinutosNocturnosY] [int] NOT NULL,
	[TotalMinutos911] [int] NOT NULL,
	[TotalMinutos110] [int] NOT NULL,
	[TotalMinutosNocturnos800] [int] NOT NULL,
	[TotalMinutosNocturnos900] [int] NOT NULL,
	[TotalMinutosNocturnos911] [int] NOT NULL,
	[TotalMinutosNocturnos110] [int] NOT NULL,
	[TotalMinutosFamiliar] [int] NOT NULL,
	[TotalMinutos] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_DetalleFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutosBase]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutosAdicional]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutosNocturnos]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutos800]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutos900]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutosEmpresaX]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutosEmpresaY]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutosNocturnosX]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutosNocturnosY]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutos911]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutos110]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutosNocturnos800]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutosNocturnos900]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutosNocturnos911]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutosNocturnos110]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutosFamiliar]
GO

ALTER TABLE [dbo].[DetalleLlamadas] ADD  DEFAULT ((0)) FOR [TotalMinutos]
GO

ALTER TABLE [dbo].[DetalleLlamadas]  WITH CHECK ADD FOREIGN KEY([ID_DetalleFactura])
REFERENCES [dbo].[DetalleFactura] ([ID_Facturas])
GO

