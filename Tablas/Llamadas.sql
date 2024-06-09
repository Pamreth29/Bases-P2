USE [NewTelefoneria]
GO

/****** Object:  Table [dbo].[Llamadas]    Script Date: 9/6/2024 11:42:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Llamadas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NumeroDe] [varchar](64) NOT NULL,
	[NumeroA] [varchar](64) NOT NULL,
	[FechaHora_Inicio] [datetime] NOT NULL,
	[FechaHora_Fin] [datetime] NOT NULL,
 CONSTRAINT [PK_Llamadas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

