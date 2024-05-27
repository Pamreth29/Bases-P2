USE [Proyecto2]
GO

/****** Object:  Table [dbo].[DetalleLlamada]    Script Date: 26/5/2024 23:54:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleLlamada](
	[ID_DetalleFactura] [int] NOT NULL,
	[ID_Llamada] [int] NOT NULL,
	[QMinutos] [int] NOT NULL,
 CONSTRAINT [PK_DetalleLlamada] PRIMARY KEY CLUSTERED 
(
	[ID_DetalleFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleLlamada]  WITH CHECK ADD  CONSTRAINT [FK_DetalleLlamada_DetalleFactura] FOREIGN KEY([ID_DetalleFactura])
REFERENCES [dbo].[DetalleFactura] ([Id])
GO

ALTER TABLE [dbo].[DetalleLlamada] CHECK CONSTRAINT [FK_DetalleLlamada_DetalleFactura]
GO

ALTER TABLE [dbo].[DetalleLlamada]  WITH CHECK ADD  CONSTRAINT [FK_DetalleLlamada_Llamadas] FOREIGN KEY([ID_Llamada])
REFERENCES [dbo].[Llamadas] ([Id])
GO

ALTER TABLE [dbo].[DetalleLlamada] CHECK CONSTRAINT [FK_DetalleLlamada_Llamadas]
GO

