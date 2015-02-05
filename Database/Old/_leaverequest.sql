USE [_LeaveRequest]
GO
/****** Object:  Table [dbo].[Histories]    Script Date: 12/28/2014 8:24:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Histories](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[changing_username] [nvarchar](max) NULL,
	[change_event] [int] NOT NULL,
	[change_time] [datetime] NOT NULL,
	[edits] [nvarchar](max) NULL,
	[Request_RequestID] [int] NULL,
 CONSTRAINT [PK_dbo.Histories] PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Requests]    Script Date: 12/28/2014 8:24:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requests](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](max) NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NOT NULL,
	[notes] [nvarchar](140) NULL,
	[LeaveType] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[TeamLead] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Requests] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[Histories]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Histories_dbo.Requests_Request_RequestID] FOREIGN KEY([Request_RequestID])
REFERENCES [dbo].[Requests] ([RequestID])
GO
ALTER TABLE [dbo].[Histories] CHECK CONSTRAINT [FK_dbo.Histories_dbo.Requests_Request_RequestID]
GO
