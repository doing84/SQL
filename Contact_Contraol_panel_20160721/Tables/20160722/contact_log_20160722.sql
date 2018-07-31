USE [CEW]
GO

/****** Object:  Table [dbo].[contact_log]    Script Date: 07/22/2016 19:31:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[contact_log](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[contact_id] [int] NOT NULL,
	[login_id] [int] NULL,
	[contact_email] [varchar](50) NOT NULL,
	[email_type] [char](1) NOT NULL,
	[log_desc] [varchar](1000) NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
 CONSTRAINT [PK_contact_log] PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[contact_log] ADD  CONSTRAINT [DF_contact_log_login_id]  DEFAULT ((0)) FOR [login_id]
GO

ALTER TABLE [dbo].[contact_log] ADD  CONSTRAINT [DF_contact_log_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[contact_log] ADD  CONSTRAINT [DF_contact_log_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


