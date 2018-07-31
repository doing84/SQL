USE [CEW]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[employment_job_status](
	[status_code] [char](1) NOT NULL,
	[status_desc] [varchar](50) NOT NULL,
	[user_friendly_desc] [varchar](100) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


