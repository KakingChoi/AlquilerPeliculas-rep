USE [master]
GO
/****** Object:  Database [TiendaPeliculas]    Script Date: 3/31/2018 11:00:46 AM ******/
CREATE DATABASE [TiendaPeliculas]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TiendaPeliculas', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\TiendaPeliculas.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TiendaPeliculas_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\TiendaPeliculas_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TiendaPeliculas] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TiendaPeliculas].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TiendaPeliculas] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET ARITHABORT OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TiendaPeliculas] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TiendaPeliculas] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TiendaPeliculas] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TiendaPeliculas] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TiendaPeliculas] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TiendaPeliculas] SET  MULTI_USER 
GO
ALTER DATABASE [TiendaPeliculas] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TiendaPeliculas] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TiendaPeliculas] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TiendaPeliculas] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TiendaPeliculas] SET DELAYED_DURABILITY = DISABLED 
GO
USE [TiendaPeliculas]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/31/2018 11:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Client]    Script Date: 3/31/2018 11:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Client](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NOT NULL,
	[Phone] [varchar](20) NOT NULL,
	[Adress] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Movie]    Script Date: 3/31/2018 11:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movie](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](128) NOT NULL,
	[Description] [varchar](max) NULL,
	[CategoryId] [int] NULL,
	[Year] [int] NOT NULL,
	[Stock] [int] NULL,
	[Exhausted] [bit] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ParametersRental]    Script Date: 3/31/2018 11:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParametersRental](
	[Id] [int] NOT NULL,
	[CostPerday] [float] NULL,
	[CostRental] [float] NULL,
	[CostRentalExhausted] [float] NULL,
	[Penality] [float] NULL,
	[MaxDay] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RentalDetail]    Script Date: 3/31/2018 11:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentalDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RentalId] [int] NULL,
	[MovieId] [int] NULL,
	[Price] [float] NULL,
	[Quantity] [int] NULL,
	[SubTotal] [float] NULL,
	[isDevuelta] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RentalMovie]    Script Date: 3/31/2018 11:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentalMovie](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[clientId] [int] NOT NULL,
	[DateRental] [datetime] NULL,
	[Days] [int] NULL,
	[DateRetund] [datetime] NULL,
	[QuantityMovie] [int] NULL,
	[Total] [float] NOT NULL,
	[StatusId] [int] NULL,
	[UserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReturnMovie]    Script Date: 3/31/2018 11:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnMovie](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MovieId] [int] NULL,
	[clientId] [int] NOT NULL,
	[Quantity] [int] NULL,
	[DateReturn] [datetime] NULL,
	[RentalDetailsId] [int] NOT NULL,
	[Penality] [bit] NULL,
	[Mount] [float] NULL,
	[Status] [bit] NULL,
	[UserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StatusRental]    Script Date: 3/31/2018 11:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StatusRental](
	[Id] [int] NOT NULL,
	[Description] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 3/31/2018 11:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UsarName] [varchar](100) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[Name] [varchar](128) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Name]) VALUES (1, N'Comedia')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (3, N'Terror 1')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([Id], [Name], [Phone], [Adress]) VALUES (1, N'Kaking Choi', N'809-816-3364', N'C/Venecia #4')
SET IDENTITY_INSERT [dbo].[Client] OFF
SET IDENTITY_INSERT [dbo].[Movie] ON 

INSERT [dbo].[Movie] ([Id], [Title], [Description], [CategoryId], [Year], [Stock], [Exhausted], [Status]) VALUES (2, N'Avengers', N'Los vengadores', 1, 2015, 10, 1, NULL)
INSERT [dbo].[Movie] ([Id], [Title], [Description], [CategoryId], [Year], [Stock], [Exhausted], [Status]) VALUES (3, N'Tom Raiden', N'las aventuras de Lara Cross', 1, 2018, 5, 0, 1)
INSERT [dbo].[Movie] ([Id], [Title], [Description], [CategoryId], [Year], [Stock], [Exhausted], [Status]) VALUES (4, N'Los Mercenarios', N'Un grupo de mercenarios de elite', 1, 2013, 6, 0, 1)
SET IDENTITY_INSERT [dbo].[Movie] OFF
INSERT [dbo].[ParametersRental] ([Id], [CostPerday], [CostRental], [CostRentalExhausted], [Penality], [MaxDay]) VALUES (1, 500, 500, 1000, 5, 10)
SET IDENTITY_INSERT [dbo].[RentalDetail] ON 

INSERT [dbo].[RentalDetail] ([Id], [RentalId], [MovieId], [Price], [Quantity], [SubTotal], [isDevuelta]) VALUES (1, 1, 2, 1000, 1, 1000, 1)
INSERT [dbo].[RentalDetail] ([Id], [RentalId], [MovieId], [Price], [Quantity], [SubTotal], [isDevuelta]) VALUES (2, 1, 3, 500, 1, 500, 0)
INSERT [dbo].[RentalDetail] ([Id], [RentalId], [MovieId], [Price], [Quantity], [SubTotal], [isDevuelta]) VALUES (3, 2, 2, 1000, 1, 1000, 1)
INSERT [dbo].[RentalDetail] ([Id], [RentalId], [MovieId], [Price], [Quantity], [SubTotal], [isDevuelta]) VALUES (4, 2, 3, 500, 1, 500, 1)
INSERT [dbo].[RentalDetail] ([Id], [RentalId], [MovieId], [Price], [Quantity], [SubTotal], [isDevuelta]) VALUES (5, 3, 4, 500, 1, 500, 1)
SET IDENTITY_INSERT [dbo].[RentalDetail] OFF
SET IDENTITY_INSERT [dbo].[RentalMovie] ON 

INSERT [dbo].[RentalMovie] ([Id], [clientId], [DateRental], [Days], [DateRetund], [QuantityMovie], [Total], [StatusId], [UserId]) VALUES (1, 1, CAST(N'2018-03-30 20:06:31.583' AS DateTime), 5, CAST(N'2018-04-04 20:06:31.583' AS DateTime), 2, 1500, 2, 1)
INSERT [dbo].[RentalMovie] ([Id], [clientId], [DateRental], [Days], [DateRetund], [QuantityMovie], [Total], [StatusId], [UserId]) VALUES (2, 1, CAST(N'2018-03-30 20:10:59.290' AS DateTime), 5, CAST(N'2018-04-04 20:10:59.290' AS DateTime), 2, 1500, 3, 1)
INSERT [dbo].[RentalMovie] ([Id], [clientId], [DateRental], [Days], [DateRetund], [QuantityMovie], [Total], [StatusId], [UserId]) VALUES (3, 1, CAST(N'2018-03-30 20:11:37.240' AS DateTime), 2, CAST(N'2018-04-01 20:11:37.240' AS DateTime), 1, 500, 3, 1)
SET IDENTITY_INSERT [dbo].[RentalMovie] OFF
SET IDENTITY_INSERT [dbo].[ReturnMovie] ON 

INSERT [dbo].[ReturnMovie] ([Id], [MovieId], [clientId], [Quantity], [DateReturn], [RentalDetailsId], [Penality], [Mount], [Status], [UserId]) VALUES (2, 3, 1, 1, CAST(N'2018-03-31 10:49:32.813' AS DateTime), 4, 0, 0, 1, 1)
INSERT [dbo].[ReturnMovie] ([Id], [MovieId], [clientId], [Quantity], [DateReturn], [RentalDetailsId], [Penality], [Mount], [Status], [UserId]) VALUES (3, 2, 1, 1, CAST(N'2018-03-31 10:49:48.780' AS DateTime), 3, 0, 0, 1, 1)
INSERT [dbo].[ReturnMovie] ([Id], [MovieId], [clientId], [Quantity], [DateReturn], [RentalDetailsId], [Penality], [Mount], [Status], [UserId]) VALUES (4, 4, 1, 1, CAST(N'2018-03-31 10:49:56.580' AS DateTime), 5, 0, 0, 1, 1)
INSERT [dbo].[ReturnMovie] ([Id], [MovieId], [clientId], [Quantity], [DateReturn], [RentalDetailsId], [Penality], [Mount], [Status], [UserId]) VALUES (5, 2, 1, 1, CAST(N'2018-03-31 10:50:00.250' AS DateTime), 1, 0, 0, 1, 1)
SET IDENTITY_INSERT [dbo].[ReturnMovie] OFF
INSERT [dbo].[StatusRental] ([Id], [Description]) VALUES (1, N'Alquilado')
INSERT [dbo].[StatusRental] ([Id], [Description]) VALUES (2, N'Devuelta Parcial')
INSERT [dbo].[StatusRental] ([Id], [Description]) VALUES (3, N'Devuelta Total')
INSERT [dbo].[StatusRental] ([Id], [Description]) VALUES (4, N'Penalizado')
INSERT [dbo].[StatusRental] ([Id], [Description]) VALUES (5, N'Perdido')
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([Id], [UsarName], [Password], [Name]) VALUES (1, N'Admin', N'admin', N'Kaking Choi De La Cruz')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[RentalDetail]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movie] ([Id])
GO
ALTER TABLE [dbo].[RentalDetail]  WITH CHECK ADD FOREIGN KEY([RentalId])
REFERENCES [dbo].[RentalMovie] ([Id])
GO
ALTER TABLE [dbo].[RentalMovie]  WITH CHECK ADD FOREIGN KEY([clientId])
REFERENCES [dbo].[Client] ([Id])
GO
ALTER TABLE [dbo].[RentalMovie]  WITH CHECK ADD FOREIGN KEY([StatusId])
REFERENCES [dbo].[StatusRental] ([Id])
GO
ALTER TABLE [dbo].[RentalMovie]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[ReturnMovie]  WITH CHECK ADD FOREIGN KEY([clientId])
REFERENCES [dbo].[Client] ([Id])
GO
ALTER TABLE [dbo].[ReturnMovie]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movie] ([Id])
GO
ALTER TABLE [dbo].[ReturnMovie]  WITH CHECK ADD FOREIGN KEY([RentalDetailsId])
REFERENCES [dbo].[RentalDetail] ([Id])
GO
ALTER TABLE [dbo].[ReturnMovie]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
USE [master]
GO
ALTER DATABASE [TiendaPeliculas] SET  READ_WRITE 
GO
