USE [CEW]
GO

/****** Object:  Table [dbo].[enroll_customer_site_test]    Script Date: 06/23/2016 15:57:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[enroll_customer_site_test](
	[enroll_site_id] [int] NOT NULL,
	[test_status] [char](1) NOT NULL,
	[register_id] [int] NOT NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
	[update_id] [int] NULL,
	[update_date] [datetime] NULL,
 CONSTRAINT [PK_enroll_customer_site_test] PRIMARY KEY CLUSTERED 
(
	[enroll_site_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[enroll_customer_site_test] ADD  CONSTRAINT [DF_enroll_customer_site_test_test_status]  DEFAULT ('I') FOR [test_status]
GO

ALTER TABLE [dbo].[enroll_customer_site_test] ADD  CONSTRAINT [DF_enroll_customer_site_test_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[enroll_customer_site_test] ADD  CONSTRAINT [DF_enroll_customer_site_test_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


