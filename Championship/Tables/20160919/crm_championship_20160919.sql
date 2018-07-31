USE [CEW]
GO

/****** Object:  Table [dbo].[crm_championship]    Script Date: 09/19/2016 08:25:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[crm_championship](
	[championship_id] [int] IDENTITY(1,1) NOT NULL,
	[championship_status] [char](1) NOT NULL,
	[championship_name] [varchar](100) NOT NULL,
	[championship_days]  AS (datediff(day,[date_begin],[date_end])+(1)),
	[date_begin] [date] NOT NULL,
	[date_end] [date] NOT NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
	[update_date] [datetime] NULL,
 CONSTRAINT [PK_crm_championship] PRIMARY KEY CLUSTERED 
(
	[championship_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[crm_championship] ADD  CONSTRAINT [DF_crm_championship_championship_status]  DEFAULT ('I') FOR [championship_status]
GO

ALTER TABLE [dbo].[crm_championship] ADD  CONSTRAINT [DF_crm_championship_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[crm_championship] ADD  CONSTRAINT [DF_crm_championship_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


