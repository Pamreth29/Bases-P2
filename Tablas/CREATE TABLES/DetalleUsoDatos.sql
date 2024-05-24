USE [Proyecto2]
GO

/****** Object:  Table [dbo].[DetalleUsoDatos]    Script Date: 23/5/2024 22:31:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleUsoDatos](
	[ID_DetalleElementosCobro] [int] NOT NULL,
	[Fecha] [date] NULL,
	[MontoGigasConsumidos] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_DetalleElementosCobro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

