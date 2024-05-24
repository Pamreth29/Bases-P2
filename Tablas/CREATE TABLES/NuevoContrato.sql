USE [Proyecto2]
GO

/****** Object:  Table [dbo].[NuevoContrato]    Script Date: 23/5/2024 22:30:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NuevoContrato](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_Cliente] [int] NULL,
	[Numero] [nvarchar](100) NOT NULL,
	[DocIdentidadCliente] [nvarchar](100) NOT NULL,
	[TipoTarifa] [int] NULL,
	[Fecha] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[NuevoContrato]  WITH CHECK ADD FOREIGN KEY([ID_Cliente])
REFERENCES [dbo].[ClienteNuevo] ([Id])
GO

ALTER TABLE [dbo].[NuevoContrato]  WITH CHECK ADD FOREIGN KEY([TipoTarifa])
REFERENCES [dbo].[TipoTarifa] ([Id])
GO

