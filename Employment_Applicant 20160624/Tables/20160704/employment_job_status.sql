USE [CEW]
GO

/****** Object:  Table [dbo].[employment_job_status]    Script Date: 07/04/2016 16:30:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[employment_job_status](
	[status_code] [char](1) NOT NULL,
	[status_desc] [varchar](50) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


