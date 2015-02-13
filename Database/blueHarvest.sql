USE [master]
GO
/****** Object:  Database [BlueHarvest]    Script Date: 2/12/2015 10:37:30 PM ******/
CREATE DATABASE [BlueHarvest]
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
ALTER DATABASE [BlueHarvest] SET DELAYED_DURABILITY = DISABLED 
GO
USE [BlueHarvest]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 2/12/2015 10:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[addressTypeID] [int] NOT NULL,
	[employeeID] [int] NOT NULL,
	[streetAddress] [nvarchar](max) NOT NULL,
	[streetAddressUnit] [nvarchar](50) NOT NULL,
	[city] [nvarchar](max) NOT NULL,
	[state] [nvarchar](max) NOT NULL,
	[zipCode] [int] NOT NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AddressTypes]    Script Date: 2/12/2015 10:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AddressTypes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](10) NOT NULL,
 CONSTRAINT [PK_AddressTypes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 2/12/2015 10:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employees](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[teamID] [int] NOT NULL,
	[userName] [varchar](50) NOT NULL,
	[password] [varchar](100) NOT NULL,
	[displayName] [varchar](100) NOT NULL,
	[jobTitle] [varchar](50) NOT NULL,
	[company] [varchar](50) NOT NULL,
	[emailAddress] [varchar](50) NOT NULL,
	[startDate] [datetime] NOT NULL,
	[endDate] [datetime] NULL,
	[isManager] [bit] NOT NULL,
	[deactivated] [bit] NOT NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmployeeTasks]    Script Date: 2/12/2015 10:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeTasks](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[employeeID] [int] NOT NULL,
	[taskID] [int] NOT NULL,
 CONSTRAINT [PK_EmployeeTasks] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OnCall]    Script Date: 2/12/2015 10:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OnCall](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[employeeID] [int] NOT NULL,
	[shiftStart] [datetime] NOT NULL,
	[shiftFinish] [datetime] NOT NULL,
 CONSTRAINT [PK_OnCall] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhoneNumbers]    Script Date: 2/12/2015 10:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneNumbers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[phoneTypeID] [int] NOT NULL,
	[employeeID] [int] NOT NULL,
	[phoneNumber] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_PhoneNumbers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhoneTypes]    Script Date: 2/12/2015 10:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PhoneTypes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](10) NOT NULL,
 CONSTRAINT [PK_PhoneTypes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Shifts]    Script Date: 2/12/2015 10:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shifts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[startTime] [time](7) NOT NULL,
	[endTime] [time](7) NOT NULL,
	[day] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
 CONSTRAINT [PK_Shifts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Task]    Script Date: 2/12/2015 10:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Task](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[description] [varchar](1000) NOT NULL,
	[startDate] [datetime] NULL,
	[dueDate] [datetime] NOT NULL,
	[endDate] [datetime] NULL,
	[notes] [varchar](max) NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Teams]    Script Date: 2/12/2015 10:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teams](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VacationRequests]    Script Date: 2/12/2015 10:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VacationRequests](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[employeeID] [int] NOT NULL,
	[startDate] [datetime] NOT NULL,
	[endDate] [datetime] NOT NULL,
	[notes] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Requests] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[ManagerView]    Script Date: 2/12/2015 10:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ManagerView]
AS
SELECT        dbo.Employees.id, dbo.Employees.teamID, dbo.Employees.userName, dbo.Employees.password, dbo.Employees.displayName, dbo.Employees.jobTitle, dbo.Employees.emailAddress, 
                         dbo.Employees.isManager, dbo.Teams.name AS teamName, dbo.Shifts.startTime, dbo.Shifts.endTime
FROM            dbo.Employees INNER JOIN
                         dbo.Teams ON dbo.Employees.teamID = dbo.Teams.id INNER JOIN
                         dbo.Shifts ON dbo.Employees.id = dbo.Shifts.EmployeeID
WHERE        (dbo.Employees.isManager = 1)




GO
/****** Object:  View [dbo].[OnCallView]    Script Date: 2/12/2015 10:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OnCallView]
AS
SELECT        dbo.Employees.id, dbo.Employees.teamID, dbo.Employees.userName, dbo.Employees.password, dbo.Employees.displayName, dbo.Employees.jobTitle, dbo.Employees.emailAddress, 
                         dbo.Employees.isManager, dbo.OnCall.shiftStart, dbo.OnCall.shiftFinish, dbo.Teams.name AS teamName
FROM            dbo.Employees INNER JOIN
                         dbo.OnCall ON dbo.Employees.id = dbo.OnCall.employeeID INNER JOIN
                         dbo.Teams ON dbo.Employees.teamID = dbo.Teams.id




GO
/****** Object:  View [dbo].[ShiftView]    Script Date: 2/12/2015 10:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ShiftView]
AS
SELECT        dbo.Employees.id, dbo.Employees.teamID, dbo.Employees.userName, dbo.Employees.password, dbo.Employees.displayName, dbo.Employees.jobTitle, dbo.Employees.emailAddress, 
                         dbo.Employees.isManager, dbo.Shifts.startTime, dbo.Shifts.endTime, dbo.Shifts.day, dbo.Teams.name AS teamName
FROM            dbo.Employees INNER JOIN
                         dbo.Shifts ON dbo.Employees.id = dbo.Shifts.EmployeeID INNER JOIN
                         dbo.Teams ON dbo.Employees.teamID = dbo.Teams.id




GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF_Employees_isManager]  DEFAULT ((0)) FOR [isManager]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_AddressesTypes] FOREIGN KEY([addressTypeID])
REFERENCES [dbo].[AddressTypes] ([id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_AddressesTypes]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Employee] FOREIGN KEY([employeeID])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Employee]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Teams] FOREIGN KEY([teamID])
REFERENCES [dbo].[Teams] ([id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Teams]
GO
ALTER TABLE [dbo].[EmployeeTasks]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeTasks_Employee] FOREIGN KEY([employeeID])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[EmployeeTasks] CHECK CONSTRAINT [FK_EmployeeTasks_Employee]
GO
ALTER TABLE [dbo].[EmployeeTasks]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeTasks_EmployeeTasks] FOREIGN KEY([taskID])
REFERENCES [dbo].[Task] ([id])
GO
ALTER TABLE [dbo].[EmployeeTasks] CHECK CONSTRAINT [FK_EmployeeTasks_EmployeeTasks]
GO
ALTER TABLE [dbo].[OnCall]  WITH CHECK ADD  CONSTRAINT [FK_OnCall_Employees] FOREIGN KEY([employeeID])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[OnCall] CHECK CONSTRAINT [FK_OnCall_Employees]
GO
ALTER TABLE [dbo].[PhoneNumbers]  WITH CHECK ADD  CONSTRAINT [FK_PhoneNumbers_Employees] FOREIGN KEY([employeeID])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[PhoneNumbers] CHECK CONSTRAINT [FK_PhoneNumbers_Employees]
GO
ALTER TABLE [dbo].[PhoneNumbers]  WITH CHECK ADD  CONSTRAINT [FK_PhoneNumbers_PhoneTypes] FOREIGN KEY([phoneTypeID])
REFERENCES [dbo].[PhoneTypes] ([id])
GO
ALTER TABLE [dbo].[PhoneNumbers] CHECK CONSTRAINT [FK_PhoneNumbers_PhoneTypes]
GO
ALTER TABLE [dbo].[Shifts]  WITH CHECK ADD  CONSTRAINT [FK_Shifts_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[Shifts] CHECK CONSTRAINT [FK_Shifts_Employees]
GO
ALTER TABLE [dbo].[VacationRequests]  WITH CHECK ADD  CONSTRAINT [FK_Requests_Employees] FOREIGN KEY([employeeID])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[VacationRequests] CHECK CONSTRAINT [FK_Requests_Employees]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Employees"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 214
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Teams"
            Begin Extent = 
               Top = 114
               Left = 253
               Bottom = 261
               Right = 423
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Shifts"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 170
               Right = 635
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ManagerView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ManagerView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Employees"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OnCall"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 177
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Teams"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 152
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OnCallView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OnCallView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Employees"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Shifts"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 171
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Teams"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 164
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ShiftView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ShiftView'
GO
USE [master]
GO
ALTER DATABASE [BlueHarvest] SET  READ_WRITE 
GO
