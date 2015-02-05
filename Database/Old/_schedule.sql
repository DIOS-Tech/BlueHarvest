USE [_Schedule]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 12/28/2014 8:25:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](max) NULL,
	[name] [nvarchar](max) NULL,
	[samaccount] [nvarchar](max) NULL,
	[Team_ID] [int] NULL,
	[WatchShift_ID] [int] NULL,
 CONSTRAINT [PK_dbo.Employees] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Meetings]    Script Date: 12/28/2014 8:25:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Meetings](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[employee] [nvarchar](max) NULL,
	[subject] [nvarchar](max) NULL,
	[location] [nvarchar](max) NULL,
	[start] [datetime] NOT NULL,
	[finish] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.Meetings] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MODs]    Script Date: 12/28/2014 8:25:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MODs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[start] [datetime] NOT NULL,
	[finish] [datetime] NOT NULL,
	[manager_ID] [int] NULL,
 CONSTRAINT [PK_dbo.MODs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shifts]    Script Date: 12/28/2014 8:25:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shifts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Day] [nvarchar](max) NULL,
	[startHour] [int] NOT NULL,
	[endHour] [int] NOT NULL,
	[Employee_ID] [int] NULL,
 CONSTRAINT [PK_dbo.Shifts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Teams]    Script Date: 12/28/2014 8:25:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teams](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NULL,
	[teamlead_ID] [int] NULL,
 CONSTRAINT [PK_dbo.Teams] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WatchShifts]    Script Date: 12/28/2014 8:25:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WatchShifts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ShiftName] [nvarchar](max) NULL,
	[Senior_ID] [int] NULL,
	[Officer_ID] [int] NULL,
	[Stander_ID] [int] NULL,
 CONSTRAINT [PK_dbo.WatchShifts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Employees_dbo.Teams_Team_ID] FOREIGN KEY([Team_ID])
REFERENCES [dbo].[Teams] ([ID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_dbo.Employees_dbo.Teams_Team_ID]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Employees_dbo.WatchShifts_WatchShift_ID] FOREIGN KEY([WatchShift_ID])
REFERENCES [dbo].[WatchShifts] ([ID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_dbo.Employees_dbo.WatchShifts_WatchShift_ID]
GO
ALTER TABLE [dbo].[MODs]  WITH CHECK ADD  CONSTRAINT [FK_dbo.MODs_dbo.Employees_manager_ID] FOREIGN KEY([manager_ID])
REFERENCES [dbo].[Employees] ([ID])
GO
ALTER TABLE [dbo].[MODs] CHECK CONSTRAINT [FK_dbo.MODs_dbo.Employees_manager_ID]
GO
ALTER TABLE [dbo].[Shifts]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Shifts_dbo.Employees_Employee_ID] FOREIGN KEY([Employee_ID])
REFERENCES [dbo].[Employees] ([ID])
GO
ALTER TABLE [dbo].[Shifts] CHECK CONSTRAINT [FK_dbo.Shifts_dbo.Employees_Employee_ID]
GO
ALTER TABLE [dbo].[Teams]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Teams_dbo.Employees_teamlead_ID] FOREIGN KEY([teamlead_ID])
REFERENCES [dbo].[Employees] ([ID])
GO
ALTER TABLE [dbo].[Teams] CHECK CONSTRAINT [FK_dbo.Teams_dbo.Employees_teamlead_ID]
GO
ALTER TABLE [dbo].[WatchShifts]  WITH CHECK ADD  CONSTRAINT [FK_dbo.WatchShifts_dbo.Employees_Officer_ID] FOREIGN KEY([Officer_ID])
REFERENCES [dbo].[Employees] ([ID])
GO
ALTER TABLE [dbo].[WatchShifts] CHECK CONSTRAINT [FK_dbo.WatchShifts_dbo.Employees_Officer_ID]
GO
ALTER TABLE [dbo].[WatchShifts]  WITH CHECK ADD  CONSTRAINT [FK_dbo.WatchShifts_dbo.Employees_Senior_ID] FOREIGN KEY([Senior_ID])
REFERENCES [dbo].[Employees] ([ID])
GO
ALTER TABLE [dbo].[WatchShifts] CHECK CONSTRAINT [FK_dbo.WatchShifts_dbo.Employees_Senior_ID]
GO
ALTER TABLE [dbo].[WatchShifts]  WITH CHECK ADD  CONSTRAINT [FK_dbo.WatchShifts_dbo.Employees_Stander_ID] FOREIGN KEY([Stander_ID])
REFERENCES [dbo].[Employees] ([ID])
GO
ALTER TABLE [dbo].[WatchShifts] CHECK CONSTRAINT [FK_dbo.WatchShifts_dbo.Employees_Stander_ID]
GO
