USE [master]
GO
/****** Object:  Database [WIFI]    Script Date: 19/11/2023 11:17:12 ******/
CREATE DATABASE [WIFI]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WIFI', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\WIFI.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WIFI_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\WIFI_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [WIFI] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WIFI].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WIFI] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WIFI] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WIFI] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WIFI] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WIFI] SET ARITHABORT OFF 
GO
ALTER DATABASE [WIFI] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WIFI] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WIFI] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WIFI] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WIFI] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WIFI] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WIFI] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WIFI] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WIFI] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WIFI] SET  ENABLE_BROKER 
GO
ALTER DATABASE [WIFI] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WIFI] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WIFI] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WIFI] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WIFI] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WIFI] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WIFI] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WIFI] SET RECOVERY FULL 
GO
ALTER DATABASE [WIFI] SET  MULTI_USER 
GO
ALTER DATABASE [WIFI] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WIFI] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WIFI] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WIFI] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WIFI] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WIFI] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'WIFI', N'ON'
GO
ALTER DATABASE [WIFI] SET QUERY_STORE = ON
GO
ALTER DATABASE [WIFI] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [WIFI]
GO
/****** Object:  Table [dbo].[Tipo_Documento]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_Documento](
	[Id_TipoDocumento] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_TipoDocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Persona]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persona](
	[Id_Persona] [int] IDENTITY(1,1) NOT NULL,
	[Nombres] [varchar](50) NOT NULL,
	[Apellido_Paterno] [varchar](50) NULL,
	[Apellido_Materno] [varchar](50) NULL,
	[Fecha_Nacimiento] [date] NOT NULL,
	[Correo_Electronico] [varchar](100) NOT NULL,
	[Numero_Celular] [varchar](25) NOT NULL,
	[Tipo_Persona] [varchar](10) NOT NULL,
	[Nro_Identificacion] [varchar](15) NOT NULL,
	[Id_TipoDocumento] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Persona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VPERSONA]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Crear la vista VPERSONA
CREATE VIEW [dbo].[VPERSONA] AS
SELECT
    P.Id_Persona AS Id,
    P.Nombres AS Nombres,
    P.Apellido_Paterno AS Apellido_Paterno,
    P.Apellido_Materno AS Apellido_Materno,
    P.Fecha_Nacimiento AS Fecha_Nacimiento,
    P.Correo_Electronico AS Correo_Electronico,
    P.Tipo_Persona AS Tipo_Persona,
    P.Numero_Celular AS Numero_Celular,
    P.Nro_Identificacion AS Nro_Identificacion,
    TD.Nombre AS Tipo_Documento
FROM PERSONA AS P
INNER JOIN Tipo_Documento AS TD ON P.Id_TipoDocumento = TD.Id_TipoDocumento;

GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[Id_Usuario] [int] IDENTITY(1,1) NOT NULL,
	[Usuario] [varchar](30) NOT NULL,
	[Contrasenia] [varchar](50) NOT NULL,
	[Id_Persona] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol](
	[Id_Rol] [int] IDENTITY(1,1) NOT NULL,
	[Funcion] [varchar](10) NOT NULL,
	[Id_Usuario] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VUSUARIO]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Crear la vista VUSUARIO
CREATE VIEW [dbo].[VUSUARIO] AS
SELECT
    U.Id_Usuario AS Id,
    U.Usuario AS Usuario,
    U.Contrasenia AS Contrasenia,
    U.Id_Persona AS Id_Persona,
    P.Nombres AS Nombres,
    P.Numero_Celular AS Numero_Celular,
    P.Nro_Identificacion AS Nro_Identificacion,
    R.Id_Rol AS IdRol,
    R.Funcion AS RolFuncion
FROM USUARIO AS U
INNER JOIN PERSONA AS P ON U.Id_Persona = P.Id_Persona
INNER JOIN ROL AS R ON P.Id_Persona = R.Id_Rol;
GO
/****** Object:  Table [dbo].[Asistencia]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Asistencia](
	[Id_Asistencia] [int] IDENTITY(1,1) NOT NULL,
	[FechaAsistencia] [date] NOT NULL,
	[FechaReali] [datetime] NOT NULL,
	[Tipo_Servicio] [varchar](50) NOT NULL,
	[Observaciones] [text] NULL,
	[Id_Contrato] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Asistencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contrato]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contrato](
	[Id_Contrato] [int] IDENTITY(1,1) NOT NULL,
	[DuracionContratoMes] [int] NOT NULL,
	[Fecha_Contrato] [date] NOT NULL,
	[Fecha_VenContrato] [date] NOT NULL,
	[Tipo_Comprobante] [varchar](30) NOT NULL,
	[Modo_Pago] [varchar](50) NOT NULL,
	[Monto_TarifaPlana] [money] NOT NULL,
	[Monto_Pagado] [money] NOT NULL,
	[Estado] [varchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Contrato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contrato_Usuario]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contrato_Usuario](
	[Id_Contr_Usuario] [int] IDENTITY(1,1) NOT NULL,
	[Id_Usuario] [int] NULL,
	[Id_Contrato] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Contr_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cronograma]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cronograma](
	[Id_Cronograma] [int] IDENTITY(1,1) NOT NULL,
	[Id_Contrato] [int] NULL,
	[Nro_Cuota] [numeric](18, 0) NOT NULL,
	[FechaVenc] [date] NOT NULL,
	[Mes] [tinyint] NULL,
	[MesLetra] [varchar](3) NULL,
	[Anio] [int] NULL,
	[PenalidadMes] [money] NULL,
	[Aniadido] [money] NULL,
	[DeudaAnt] [money] NULL,
	[TotalPago] [money] NOT NULL,
	[Fecha_Pago] [date] NOT NULL,
	[Estado_Pago] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Cronograma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detalle_Contrato]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_Contrato](
	[Id_DetalleContrato] [int] IDENTITY(1,1) NOT NULL,
	[Id_Producto_Servicio] [int] NULL,
	[Id_Contrato] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_DetalleContrato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Direccion]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Direccion](
	[Id_Direccion] [int] IDENTITY(1,1) NOT NULL,
	[Calle] [varchar](75) NOT NULL,
	[Referencia] [text] NULL,
	[Id_Persona] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Direccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ERROR]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERROR](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Url] [nvarchar](max) NULL,
	[Controller] [nvarchar](200) NULL,
	[Ip] [nvarchar](100) NULL,
	[Method] [nvarchar](20) NULL,
	[User_agent] [nvarchar](150) NULL,
	[Host] [nvarchar](max) NULL,
	[Class_component] [nvarchar](100) NULL,
	[Function_name] [nvarchar](100) NULL,
	[Line_number] [int] NULL,
	[Error] [nvarchar](max) NULL,
	[StackTrace] [nvarchar](max) NULL,
	[Status] [smallint] NULL,
	[Request] [nvarchar](max) NULL,
	[Error_code] [int] NULL,
	[Id_Persona] [int] NULL,
	[Usuario_Crea] [int] NULL,
	[Usuario_Actualiza] [int] NULL,
	[Fecha_crea] [datetime2](7) NULL,
	[Fecha_actualiza] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Imagen]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Imagen](
	[Id_Imagen] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](150) NOT NULL,
	[Id_ProductoServicio] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Imagen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producto_Cliente]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto_Cliente](
	[Id_ProducClien] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](150) NOT NULL,
	[Estado] [varchar](50) NOT NULL,
	[Observacion] [text] NULL,
	[Id_Contrato] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_ProducClien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producto_Servicio]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto_Servicio](
	[Id_ProdServ] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](75) NOT NULL,
	[Descripcion] [text] NULL,
	[Puntuacion] [tinyint] NULL,
	[Stock_Min] [int] NOT NULL,
	[Stock_Actual] [int] NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[Estado] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_ProdServ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quejas_Reclamos]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quejas_Reclamos](
	[Id_QuejaReclamo] [int] IDENTITY(1,1) NOT NULL,
	[Id_Contrato] [int] NULL,
	[Fecha_QuejaReclamo] [date] NOT NULL,
	[Descripcion] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_QuejaReclamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ubigeo]    Script Date: 19/11/2023 11:17:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ubigeo](
	[Id_Ubigeo] [int] IDENTITY(1,1) NOT NULL,
	[Departamento] [varchar](15) NOT NULL,
	[Provincia] [varchar](15) NULL,
	[Distrito] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Ubigeo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Asistencia]  WITH CHECK ADD FOREIGN KEY([Id_Contrato])
REFERENCES [dbo].[Contrato] ([Id_Contrato])
GO
ALTER TABLE [dbo].[Contrato_Usuario]  WITH CHECK ADD FOREIGN KEY([Id_Contrato])
REFERENCES [dbo].[Contrato] ([Id_Contrato])
GO
ALTER TABLE [dbo].[Contrato_Usuario]  WITH CHECK ADD FOREIGN KEY([Id_Usuario])
REFERENCES [dbo].[Usuario] ([Id_Usuario])
GO
ALTER TABLE [dbo].[Cronograma]  WITH CHECK ADD FOREIGN KEY([Id_Contrato])
REFERENCES [dbo].[Contrato] ([Id_Contrato])
GO
ALTER TABLE [dbo].[Detalle_Contrato]  WITH CHECK ADD FOREIGN KEY([Id_Contrato])
REFERENCES [dbo].[Contrato] ([Id_Contrato])
GO
ALTER TABLE [dbo].[Detalle_Contrato]  WITH CHECK ADD FOREIGN KEY([Id_Producto_Servicio])
REFERENCES [dbo].[Producto_Servicio] ([Id_ProdServ])
GO
ALTER TABLE [dbo].[Direccion]  WITH CHECK ADD FOREIGN KEY([Id_Persona])
REFERENCES [dbo].[Persona] ([Id_Persona])
GO
ALTER TABLE [dbo].[ERROR]  WITH CHECK ADD  CONSTRAINT [FK_Error_Persona] FOREIGN KEY([Id_Persona])
REFERENCES [dbo].[Persona] ([Id_Persona])
GO
ALTER TABLE [dbo].[ERROR] CHECK CONSTRAINT [FK_Error_Persona]
GO
ALTER TABLE [dbo].[ERROR]  WITH CHECK ADD  CONSTRAINT [FK_Error_Usuario_Actualiza] FOREIGN KEY([Usuario_Actualiza])
REFERENCES [dbo].[Usuario] ([Id_Usuario])
GO
ALTER TABLE [dbo].[ERROR] CHECK CONSTRAINT [FK_Error_Usuario_Actualiza]
GO
ALTER TABLE [dbo].[ERROR]  WITH CHECK ADD  CONSTRAINT [FK_Error_Usuario_Crea] FOREIGN KEY([Usuario_Crea])
REFERENCES [dbo].[Usuario] ([Id_Usuario])
GO
ALTER TABLE [dbo].[ERROR] CHECK CONSTRAINT [FK_Error_Usuario_Crea]
GO
ALTER TABLE [dbo].[Imagen]  WITH CHECK ADD FOREIGN KEY([Id_ProductoServicio])
REFERENCES [dbo].[Producto_Servicio] ([Id_ProdServ])
GO
ALTER TABLE [dbo].[Persona]  WITH CHECK ADD FOREIGN KEY([Id_TipoDocumento])
REFERENCES [dbo].[Tipo_Documento] ([Id_TipoDocumento])
GO
ALTER TABLE [dbo].[Producto_Cliente]  WITH CHECK ADD FOREIGN KEY([Id_Contrato])
REFERENCES [dbo].[Contrato] ([Id_Contrato])
GO
ALTER TABLE [dbo].[Quejas_Reclamos]  WITH CHECK ADD FOREIGN KEY([Id_Contrato])
REFERENCES [dbo].[Contrato] ([Id_Contrato])
GO
ALTER TABLE [dbo].[Rol]  WITH CHECK ADD FOREIGN KEY([Id_Usuario])
REFERENCES [dbo].[Usuario] ([Id_Usuario])
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD FOREIGN KEY([Id_Persona])
REFERENCES [dbo].[Persona] ([Id_Persona])
GO
USE [master]
GO
ALTER DATABASE [WIFI] SET  READ_WRITE 
GO
