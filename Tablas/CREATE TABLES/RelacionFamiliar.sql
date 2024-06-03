USE [Proyecto2]
GO

/****** Object:  Table [dbo].[RelacionFamiliar]    Script Date: 3/6/2024 02:48:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RelacionFamiliar](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_Cliente1] [int] NOT NULL,
	[ID_Cliente2] [int] NOT NULL,
	[ID_TipoRelacionFamilair] [int] NOT NULL,
 CONSTRAINT [PK_RelacionFamiliar] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RelacionFamiliar]  WITH CHECK ADD  CONSTRAINT [FK_RelacionFamiliar_Clientes] FOREIGN KEY([ID_Cliente1])
REFERENCES [dbo].[Clientes] ([Id])
GO

ALTER TABLE [dbo].[RelacionFamiliar] CHECK CONSTRAINT [FK_RelacionFamiliar_Clientes]
GO

ALTER TABLE [dbo].[RelacionFamiliar]  WITH CHECK ADD  CONSTRAINT [FK_RelacionFamiliar_Clientes1] FOREIGN KEY([ID_Cliente2])
REFERENCES [dbo].[Clientes] ([Id])
GO

ALTER TABLE [dbo].[RelacionFamiliar] CHECK CONSTRAINT [FK_RelacionFamiliar_Clientes1]
GO

ALTER TABLE [dbo].[RelacionFamiliar]  WITH CHECK ADD  CONSTRAINT [FK_RelacionFamiliar_TipoRelacionFamiliar] FOREIGN KEY([ID_TipoRelacionFamilair])
REFERENCES [dbo].[TipoRelacionFamiliar] ([Id])
GO

ALTER TABLE [dbo].[RelacionFamiliar] CHECK CONSTRAINT [FK_RelacionFamiliar_TipoRelacionFamiliar]
GO

