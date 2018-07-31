USE [CEW]
GO

/****** Object:  Table [dbo].[employment_job]    Script Date: 06/30/2016 09:14:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[employment_job](
	[job_id] [int] NOT NULL,
	[dept_id] [int] NOT NULL,
	[job_title] [varchar](100) NOT NULL,
	[job_desc] [varchar](max) NULL,
	[job_status] [char](1) NOT NULL,
	[open_period] [date] NOT NULL,
	[update_id] [int] NULL,
	[update_date] [datetime] NULL,
 CONSTRAINT [PK_employment_applicant_job_list] PRIMARY KEY CLUSTERED 
(
	[job_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


