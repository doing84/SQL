USE [CEW]
GO

/****** Object:  Table [dbo].[crm_quota_rate]    Script Date: 07/08/2016 16:34:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[crm_quota_rate](
	[quota_id] [int] IDENTITY(1,1) NOT NULL,
	[quota_desc] [varchar](max) NULL,
	[value_begin] [numeric](9, 2) NOT NULL,
	[value_end] [numeric](9, 2) NOT NULL,
	[probation_file] [varchar](200) NULL,
	[template_file] [varchar](200) NULL,
	[register_id] [int] NOT NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
	[update_id] [int] NULL,
	[update_date] [datetime] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[crm_quota_rate] ADD  CONSTRAINT [DF_crm_quota_rate_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[crm_quota_rate] ADD  CONSTRAINT [DF_crm_quota_rate_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


