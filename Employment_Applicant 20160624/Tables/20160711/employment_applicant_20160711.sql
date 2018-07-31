USE [CEW]
GO

/****** Object:  Table [dbo].[employment_applicant]    Script Date: 07/11/2016 15:40:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[employment_applicant](
	[applicant_id] [int] IDENTITY(1,1) NOT NULL,
	[applicant_name] [varchar](100) NOT NULL,
	[applicant_phone] [varchar](20) NOT NULL,
	[job_id] [int] NOT NULL,
	[applicant_register_date] [date] NOT NULL,
	[applicant_register_time] [time](7) NOT NULL,
	[applicant_email] [varchar](50) NOT NULL,
	[applicant_cover_letter] [varchar](max) NULL,
	[applicant_status] [char](1) NULL,
	[file_name] [varchar](50) NULL,
	[ip_address] [varchar](20) NOT NULL,
	[email_date] [datetime] NULL,
 CONSTRAINT [PK_employment_applicant] PRIMARY KEY CLUSTERED 
(
	[applicant_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[employment_applicant] ADD  CONSTRAINT [DF_employment_applicant_register_date]  DEFAULT (getdate()) FOR [applicant_register_date]
GO

ALTER TABLE [dbo].[employment_applicant] ADD  CONSTRAINT [DF_employment_applicant_register_time]  DEFAULT (getdate()) FOR [applicant_register_time]
GO

ALTER TABLE [dbo].[employment_applicant] ADD  CONSTRAINT [DF_employment_applicant_applicant_status]  DEFAULT ('A') FOR [applicant_status]
GO


