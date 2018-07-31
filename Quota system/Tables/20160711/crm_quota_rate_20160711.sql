USE [CEW]
GO

/****** Object:  Table [dbo].[crm_quota_rate]    Script Date: 07/11/2016 11:00:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[crm_quota_rate](
	[quota_id] [int] IDENTITY(1,1) NOT NULL,
	[quota_desc] [varchar](100) NULL,
	[value_begin] [numeric](9, 2) NOT NULL,
	[value_end] [numeric](9, 2) NOT NULL,
	[probation_file] [varchar](50) NULL,
	[template_file] [varchar](50) NULL,
	[register_id] [int] NOT NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
	[update_id] [int] NULL,
	[update_date] [datetime] NULL,
 CONSTRAINT [PK_crm_quota_rate] PRIMARY KEY CLUSTERED 
(
	[quota_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[crm_quota_rate] ADD  CONSTRAINT [DF_crm_quota_rate_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[crm_quota_rate] ADD  CONSTRAINT [DF_crm_quota_rate_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


