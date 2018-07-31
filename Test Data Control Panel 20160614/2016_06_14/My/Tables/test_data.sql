USE [CEW]
GO

/****** Object:  Table [dbo].[test_data]    Script Date: 06/16/2016 19:13:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[test_data](
	[enroll_site_id] [int] NOT NULL,
	[register_id] [int] NOT NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
	[update_id] [int] NULL,
	[update_date] [datetime] NULL,
 CONSTRAINT [PK_test_data] PRIMARY KEY CLUSTERED 
(
	[enroll_site_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[test_data] ADD  CONSTRAINT [DF_test_data_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[test_data] ADD  CONSTRAINT [DF_test_data_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


