USE [master]
GO
/****** Object:  Database [BlueHarvest]    Script Date: 12/29/2014 10:43:43 PM ******/
CREATE DATABASE [BlueHarvest]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BlueHarvest', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BlueHarvest.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BlueHarvest_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BlueHarvest_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BlueHarvest] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BlueHarvest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BlueHarvest] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BlueHarvest] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BlueHarvest] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BlueHarvest] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BlueHarvest] SET ARITHABORT OFF 
GO
ALTER DATABASE [BlueHarvest] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BlueHarvest] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BlueHarvest] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BlueHarvest] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BlueHarvest] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BlueHarvest] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BlueHarvest] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BlueHarvest] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BlueHarvest] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BlueHarvest] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BlueHarvest] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BlueHarvest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BlueHarvest] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BlueHarvest] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BlueHarvest] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BlueHarvest] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BlueHarvest] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BlueHarvest] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BlueHarvest] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BlueHarvest] SET  MULTI_USER 
GO
ALTER DATABASE [BlueHarvest] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BlueHarvest] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BlueHarvest] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BlueHarvest] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [BlueHarvest]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 12/29/2014 10:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[streetAddress] [nvarchar](max) NULL,
	[streetAddressUnit] [nvarchar](50) NULL,
	[city] [nvarchar](max) NULL,
	[state] [nvarchar](max) NULL,
	[addressType] [int] NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employees]    Script Date: 12/29/2014 10:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employees](
	[id] [int] NOT NULL,
	[uniqueUserName] [varchar](max) NULL,
	[displayName] [varchar](max) NULL,
	[jobTitle] [varchar](max) NULL,
	[teamID] [int] NULL,
	[managerID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OnCall]    Script Date: 12/29/2014 10:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OnCall](
	[OnCallID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[ShiftStart] [datetime] NULL,
	[ShiftFinish] [datetime] NULL,
 CONSTRAINT [PK_OnCall] PRIMARY KEY CLUSTERED 
(
	[OnCallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhoneNumbers]    Script Date: 12/29/2014 10:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneNumbers](
	[PhoneID] [int] IDENTITY(1,1) NOT NULL,
	[phone_number] [nvarchar](max) NULL,
	[phoneType] [int] NULL,
	[EmployeeID] [int] NULL,
 CONSTRAINT [PK_PhoneNumbers] PRIMARY KEY CLUSTERED 
(
	[PhoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RequestLog]    Script Date: 12/29/2014 10:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestLog](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[changingEmployeeID] [int] NOT NULL,
	[changing_time] [datetime] NOT NULL,
	[Request_RequestID] [int] NULL,
 CONSTRAINT [PK_RequestLog] PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Requests]    Script Date: 12/29/2014 10:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requests](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NOT NULL,
	[notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_Requests] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shifts]    Script Date: 12/29/2014 10:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shifts](
	[ShiftID] [int] IDENTITY(1,1) NOT NULL,
	[startTime] [time](7) NULL,
	[endTime] [time](7) NULL,
	[day] [int] NULL,
	[EmployeeID] [int] NULL,
 CONSTRAINT [PK_Shifts] PRIMARY KEY CLUSTERED 
(
	[ShiftID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Teams]    Script Date: 12/29/2014 10:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teams](
	[TeamID] [int] NOT NULL,
	[name] [nvarchar](max) NULL,
	[description] [nvarchar](max) NULL,
	[managerID] [int] IDENTITY(0,1) NOT NULL,
 CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Index [IX_Teams]    Script Date: 12/29/2014 10:43:43 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Teams] ON [dbo].[Teams]
(
	[managerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Employees]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Managers] FOREIGN KEY([managerID])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Managers]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Teams] FOREIGN KEY([teamID])
REFERENCES [dbo].[Teams] ([TeamID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Teams]
GO
ALTER TABLE [dbo].[OnCall]  WITH CHECK ADD  CONSTRAINT [FK_OnCall_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[OnCall] CHECK CONSTRAINT [FK_OnCall_Employees]
GO
ALTER TABLE [dbo].[PhoneNumbers]  WITH CHECK ADD  CONSTRAINT [FK_PhoneNumbers_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[PhoneNumbers] CHECK CONSTRAINT [FK_PhoneNumbers_Employees]
GO
ALTER TABLE [dbo].[RequestLog]  WITH CHECK ADD  CONSTRAINT [FK_RequestLog_Employees] FOREIGN KEY([changingEmployeeID])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[RequestLog] CHECK CONSTRAINT [FK_RequestLog_Employees]
GO
ALTER TABLE [dbo].[RequestLog]  WITH CHECK ADD  CONSTRAINT [FK_RequestLog_Requests] FOREIGN KEY([Request_RequestID])
REFERENCES [dbo].[Requests] ([RequestID])
GO
ALTER TABLE [dbo].[RequestLog] CHECK CONSTRAINT [FK_RequestLog_Requests]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_Requests_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_Requests_Employees]
GO
ALTER TABLE [dbo].[Shifts]  WITH CHECK ADD  CONSTRAINT [FK_Shifts_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[Shifts] CHECK CONSTRAINT [FK_Shifts_Employees]
GO
ALTER TABLE [dbo].[Teams]  WITH CHECK ADD  CONSTRAINT [FK_Teams_Employees] FOREIGN KEY([managerID])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[Teams] CHECK CONSTRAINT [FK_Teams_Employees]
GO
USE [master]
GO
ALTER DATABASE [BlueHarvest] SET  READ_WRITE 
GO
