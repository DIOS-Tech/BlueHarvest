USE [master]
GO

/****** Object:  Database [_LeaveRequest]    Script Date: 12/26/2014 8:06:13 PM ******/
CREATE DATABASE [_LeaveRequest] ON  PRIMARY 
( NAME = N'_LeaveRequest', FILENAME = N'J:\SERVER_DATA1\_LeaveRequest.mdf' , SIZE = 2304KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'_LeaveRequest_log', FILENAME = N'K:\SERVER_LOG1\_LeaveRequest_log.LDF' , SIZE = 576KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [_LeaveRequest] SET COMPATIBILITY_LEVEL = 100
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [_LeaveRequest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [_LeaveRequest] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [_LeaveRequest] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [_LeaveRequest] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [_LeaveRequest] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [_LeaveRequest] SET ARITHABORT OFF 
GO

ALTER DATABASE [_LeaveRequest] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [_LeaveRequest] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [_LeaveRequest] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [_LeaveRequest] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [_LeaveRequest] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [_LeaveRequest] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [_LeaveRequest] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [_LeaveRequest] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [_LeaveRequest] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [_LeaveRequest] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [_LeaveRequest] SET  ENABLE_BROKER 
GO

ALTER DATABASE [_LeaveRequest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [_LeaveRequest] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [_LeaveRequest] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [_LeaveRequest] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [_LeaveRequest] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [_LeaveRequest] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [_LeaveRequest] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [_LeaveRequest] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [_LeaveRequest] SET  MULTI_USER 
GO

ALTER DATABASE [_LeaveRequest] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [_LeaveRequest] SET DB_CHAINING OFF 
GO

ALTER DATABASE [_LeaveRequest] SET  READ_WRITE 
GO


