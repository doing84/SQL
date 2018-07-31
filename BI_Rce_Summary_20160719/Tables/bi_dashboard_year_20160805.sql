USE [CEW]
GO

/****** Object:  Table [dbo].[bi_dashboard_year]    Script Date: 08/05/2016 13:34:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bi_dashboard_year](
	[year_id] [int] NOT NULL,
	[lock_yn] [bit] NOT NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
	[update_date] [datetime] NULL,
 CONSTRAINT [PK_bi_dashboard_year] PRIMARY KEY CLUSTERED 
(
	[year_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[bi_dashboard_year] ADD  CONSTRAINT [DF_bi_dashboard_year_lock_yn]  DEFAULT ((0)) FOR [lock_yn]
GO

ALTER TABLE [dbo].[bi_dashboard_year] ADD  CONSTRAINT [DF_bi_dashboard_year_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[bi_dashboard_year] ADD  CONSTRAINT [DF_bi_dashboard_year_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


