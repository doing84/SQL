USE [CEW]
GO

/****** Object:  Table [dbo].[bi_dashboard_week_summary]    Script Date: 08/05/2016 13:33:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bi_dashboard_week_summary](
	[year_id] [int] NOT NULL,
	[week_id] [int] NOT NULL,
	[total_rce_a] [numeric](9, 2) NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
	[update_date] [datetime] NULL,
 CONSTRAINT [PK_bi_dashboard_week_summary] PRIMARY KEY CLUSTERED 
(
	[year_id] ASC,
	[week_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[bi_dashboard_week_summary] ADD  CONSTRAINT [DF_bi_dashboard_week_summary_year_id]  DEFAULT ((0)) FOR [year_id]
GO

ALTER TABLE [dbo].[bi_dashboard_week_summary] ADD  CONSTRAINT [DF_bi_dashboard_week_summary_week_id]  DEFAULT ((0)) FOR [week_id]
GO

ALTER TABLE [dbo].[bi_dashboard_week_summary] ADD  CONSTRAINT [DF_bi_dashboard_week_summary_total_rce_a]  DEFAULT ((0)) FOR [total_rce_a]
GO

ALTER TABLE [dbo].[bi_dashboard_week_summary] ADD  CONSTRAINT [DF_bi_dashboard_week_summary_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[bi_dashboard_week_summary] ADD  CONSTRAINT [DF_bi_dashboard_week_summary_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


