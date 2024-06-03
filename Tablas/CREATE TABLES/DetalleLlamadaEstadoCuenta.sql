USE [Proyecto2]
GO

/****** Object:  Table [dbo].[DetalleLlamadaEstadoCuenta]    Script Date: 3/6/2024 02:47:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleLlamadaEstadoCuenta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_EstadoCuentaOperador] [int] NOT NULL,
	[HoraInicio] [datetime] NOT NULL,
	[HoraFin] [datetime] NOT NULL,
	[NumeroIniciaLlamada] [varchar](64) NOT NULL,
	[NumeroContestaLlamada] [varchar](64) NOT NULL,
 CONSTRAINT [PK_DetalleLlamadaEstadoCuenta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleLlamadaEstadoCuenta]  WITH CHECK ADD  CONSTRAINT [FK_DetalleLlamadaEstadoCuenta_EstadoCuentaOperador] FOREIGN KEY([ID_EstadoCuentaOperador])
REFERENCES [dbo].[EstadoCuentaOperador] ([ID_Operador])
GO

ALTER TABLE [dbo].[DetalleLlamadaEstadoCuenta] CHECK CONSTRAINT [FK_DetalleLlamadaEstadoCuenta_EstadoCuentaOperador]
GO

