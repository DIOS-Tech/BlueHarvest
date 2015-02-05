USE [Schedule]
GO
/****** Object:  Table [dbo].[days]    Script Date: 12/28/2014 8:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[days](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[dayOfWeek] [nvarchar](max) NULL,
	[Employee_ID] [int] NULL,
	[WatchShift_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EdmMetadata]    Script Date: 12/28/2014 8:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EdmMetadata](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ModelHash] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employees]    Script Date: 12/28/2014 8:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](max) NULL,
	[name] [nvarchar](max) NULL,
	[samaccount] [nvarchar](max) NULL,
	[shift_start] [int] NOT NULL,
	[shift_finish] [int] NOT NULL,
	[watchPosition] [int] NOT NULL,
	[team_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Meetings]    Script Date: 12/28/2014 8:23:34 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Teams]    Script Date: 12/28/2014 8:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teams](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WatchPositions]    Script Date: 12/28/2014 8:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WatchPositions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[watch_name] [nvarchar](max) NULL,
	[employee_ID] [int] NULL,
	[WatchShift_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WatchShifts]    Script Date: 12/28/2014 8:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WatchShifts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[shift_name] [nvarchar](max) NULL,
	[shift_type] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[days]  WITH CHECK ADD  CONSTRAINT [Employee_days] FOREIGN KEY([Employee_ID])
REFERENCES [dbo].[Employees] ([ID])
GO
ALTER TABLE [dbo].[days] CHECK CONSTRAINT [Employee_days]
GO
ALTER TABLE [dbo].[days]  WITH CHECK ADD  CONSTRAINT [WatchShift_days] FOREIGN KEY([WatchShift_ID])
REFERENCES [dbo].[WatchShifts] ([ID])
GO
ALTER TABLE [dbo].[days] CHECK CONSTRAINT [WatchShift_days]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [Employee_team] FOREIGN KEY([team_ID])
REFERENCES [dbo].[Teams] ([ID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [Employee_team]
GO
ALTER TABLE [dbo].[WatchPositions]  WITH CHECK ADD  CONSTRAINT [WatchPosition_employee] FOREIGN KEY([employee_ID])
REFERENCES [dbo].[Employees] ([ID])
GO
ALTER TABLE [dbo].[WatchPositions] CHECK CONSTRAINT [WatchPosition_employee]
GO
ALTER TABLE [dbo].[WatchPositions]  WITH CHECK ADD  CONSTRAINT [WatchShift_watch_positions] FOREIGN KEY([WatchShift_ID])
REFERENCES [dbo].[WatchShifts] ([ID])
GO
ALTER TABLE [dbo].[WatchPositions] CHECK CONSTRAINT [WatchShift_watch_positions]
GO
