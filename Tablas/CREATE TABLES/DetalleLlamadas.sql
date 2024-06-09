USE [Telefoneria]
GO

/****** Object:  Table [dbo].[DetalleLlamadas]    Script Date: 6/6/2024 01:52:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleLlamadas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_DetalleFactura] [int] NOT NULL,
	[ID_Llamada] [int] NOT NULL,
	[ID_TipoMinutos1] [int] NOT NULL,
	[ID_TipoMinutos2] [int] NULL,
	[Duracion] [int] NOT NULL,
 CONSTRAINT [PK_DetalleLlamadas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleLlamadas]  WITH CHECK ADD  CONSTRAINT [FK_DetalleLlamadas_DetalleFactura] FOREIGN KEY([ID_DetalleFactura])
REFERENCES [dbo].[DetalleFactura] ([ID_Facturas])
GO

ALTER TABLE [dbo].[DetalleLlamadas] CHECK CONSTRAINT [FK_DetalleLlamadas_DetalleFactura]
GO

ALTER TABLE [dbo].[DetalleLlamadas]  WITH CHECK ADD  CONSTRAINT [FK_DetalleLlamadas_Llamadas] FOREIGN KEY([ID_Llamada])
REFERENCES [dbo].[Llamadas] ([Id])
GO

ALTER TABLE [dbo].[DetalleLlamadas] CHECK CONSTRAINT [FK_DetalleLlamadas_Llamadas]
GO

ALTER TABLE [dbo].[DetalleLlamadas]  WITH CHECK ADD  CONSTRAINT [FK_DetalleLlamadas_TipoMinutos] FOREIGN KEY([ID_TipoMinutos1])
REFERENCES [dbo].[TipoMinutos] ([Id])
GO

ALTER TABLE [dbo].[DetalleLlamadas] CHECK CONSTRAINT [FK_DetalleLlamadas_TipoMinutos]
GO

ALTER TABLE [dbo].[DetalleLlamadas]  WITH CHECK ADD  CONSTRAINT [FK_DetalleLlamadas_TipoMinutos1] FOREIGN KEY([ID_TipoMinutos2])
REFERENCES [dbo].[TipoMinutos] ([Id])
GO

ALTER TABLE [dbo].[DetalleLlamadas] CHECK CONSTRAINT [FK_DetalleLlamadas_TipoMinutos1]
GO

