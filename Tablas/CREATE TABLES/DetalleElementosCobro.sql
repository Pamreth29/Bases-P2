USE [Proyecto2]
GO

/****** Object:  Table [dbo].[DetalleElementosCobro]    Script Date: 23/5/2024 22:32:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleElementosCobro](
	[id] [int] NOT NULL,
	[TarifaBasica] [int] NULL,
	[CantMinExcesoTB] [int] NULL,
	[CantGigaExcesoTB] [float] NULL,
	[CantMinFamiliares] [int] NULL,
	[Cobro_911] [float] NULL,
	[CobroTotal_110] [float] NULL,
	[CobroTotal_900] [float] NULL,
	[CobroTotal_800] [float] NULL,
	[ID_DetalleLlamada] [int] NULL,
	[ID_DetalleUsoDatos] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleElementosCobro]  WITH CHECK ADD FOREIGN KEY([ID_DetalleLlamada])
REFERENCES [dbo].[DetalleLlamada] ([ID_DetalleElementosCobro])
GO

ALTER TABLE [dbo].[DetalleElementosCobro]  WITH CHECK ADD FOREIGN KEY([ID_DetalleUsoDatos])
REFERENCES [dbo].[DetalleUsoDatos] ([ID_DetalleElementosCobro])
GO

ALTER TABLE [dbo].[DetalleElementosCobro]  WITH CHECK ADD FOREIGN KEY([TarifaBasica])
REFERENCES [dbo].[TipoTarifa] ([Id])
GO

