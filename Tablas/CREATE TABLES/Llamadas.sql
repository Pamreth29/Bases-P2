USE [Proyecto2]
GO

/****** Object:  Table [dbo].[Llamadas]    Script Date: 23/5/2024 22:30:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Llamadas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_Contrato] [int] NULL,
	[ID_TipoLlamada] [int] NULL,
	[NumeroDe] [varchar](64) NOT NULL,
	[NumeroA] [varchar](64) NOT NULL,
	[Duracion] [int] NOT NULL,
	[FechaHoraInicio] [datetime] NOT NULL,
	[FechaHoraFin] [datetime] NOT NULL,
	[CostoTotal] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Llamadas]  WITH CHECK ADD FOREIGN KEY([ID_Contrato])
REFERENCES [dbo].[NuevoContrato] ([Id])
GO

ALTER TABLE [dbo].[Llamadas]  WITH CHECK ADD FOREIGN KEY([ID_TipoLlamada])
REFERENCES [dbo].[TipoLlamada] ([Id])
GO

