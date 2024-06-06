USE [Telefoneria]
GO

/****** Object:  Table [dbo].[EstadoCuentaOperador]    Script Date: 6/6/2024 01:52:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EstadoCuentaOperador](
	[ID_Operador] [int] NOT NULL,
	[ID_TipoLlamadaOperador] [int] NOT NULL,
	[TotalMinIN] [int] NOT NULL,
	[TotalMinOut] [int] NOT NULL,
 CONSTRAINT [PK_EstadoCuentaOperador] PRIMARY KEY CLUSTERED 
(
	[ID_Operador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EstadoCuentaOperador]  WITH CHECK ADD  CONSTRAINT [FK_EstadoCuentaOperador_Operador] FOREIGN KEY([ID_Operador])
REFERENCES [dbo].[Operador] ([Id])
GO

ALTER TABLE [dbo].[EstadoCuentaOperador] CHECK CONSTRAINT [FK_EstadoCuentaOperador_Operador]
GO

