USE [CEW]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[employment_job](
	[job_id] [int] IDENTITY(1,1) NOT NULL,
	[dept_id] [int] NOT NULL,
	[job_title] [varchar](100) NOT NULL,
	[job_desc] [varchar](max) NULL,
	[job_status] [char](1) NOT NULL,
	[open_period_begin] [date] NOT NULL,
	[open_period_end] [date] NOT NULL,
	[register_id] [int] NOT NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
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

ALTER TABLE [dbo].[employment_job] ADD  CONSTRAINT [DF_employment_job_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[employment_job] ADD  CONSTRAINT [DF_employment_job_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


