USE [Proyecto2]
GO

/****** Object:  Table [dbo].[DetalleLlamada]    Script Date: 23/5/2024 22:31:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleLlamada](
	[ID_DetalleElementosCobro] [int] NOT NULL,
	[LlamadasTelefonicas] [int] NULL,
	[Fecha] [date] NULL,
	[HoraInicio] [time](7) NULL,
	[HoraFin] [time](7) NULL,
	[NumeroDesde] [nvarchar](64) NULL,
	[NumeroLlamado] [nvarchar](64) NULL,
	[CantMin] [int] NULL,
	[EsGratis] [bit] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_DetalleElementosCobro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleLlamada]  WITH CHECK ADD FOREIGN KEY([LlamadasTelefonicas])
REFERENCES [dbo].[Llamadas] ([Id])
GO

