USE [CEW]
GO

/****** Object:  Table [dbo].[contact]    Script Date: 07/29/2016 09:35:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[contact](
	[contact_id] [int] IDENTITY(1,1) NOT NULL,
	[contact_type] [char](1) NOT NULL,
	[contact_name] [varchar](100) NOT NULL,
	[contact_phone] [varchar](20) NULL,
	[contact_email] [varchar](50) NOT NULL,
	[contact_desc] [varchar](1000) NULL,
	[email_type] [char](1) NOT NULL,
	[ip_address] [varchar](20) NOT NULL,
	[log_count] [int] NOT NULL,
	[score_rate] [int] NULL,
	[register_id] [int] NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
	[update_datetime] [datetime] NULL,
	[update_date]  AS (CONVERT([date],[update_datetime],(0))),
	[update_count] [int] NOT NULL,
 CONSTRAINT [PK_contact] PRIMARY KEY CLUSTERED 
(
	[contact_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[contact] ADD  CONSTRAINT [DF_contact_email_type]  DEFAULT ('Q') FOR [email_type]
GO

ALTER TABLE [dbo].[contact] ADD  CONSTRAINT [DF_contact_log_count]  DEFAULT ((0)) FOR [log_count]
GO

ALTER TABLE [dbo].[contact] ADD  CONSTRAINT [DF_contact_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[contact] ADD  CONSTRAINT [DF_contact_register_time]  DEFAULT (getdate()) FOR [register_time]
GO

ALTER TABLE [dbo].[contact] ADD  CONSTRAINT [DF_contact_update_count]  DEFAULT ((0)) FOR [update_count]
GO


