USE [CEW]
GO

/****** Object:  Table [dbo].[crm_championship_seed_history]    Script Date: 09/14/2016 07:44:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[crm_championship_seed_history](
	[history_id] [int] IDENTITY(1,1) NOT NULL,
	[seed_id] [int] NOT NULL,
	[login_id] [int] NOT NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
 CONSTRAINT [PK_crm_championship_seed_history] PRIMARY KEY CLUSTERED 
(
	[history_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[crm_championship_seed_history] ADD  CONSTRAINT [DF_crm_championship_seed_history_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[crm_championship_seed_history] ADD  CONSTRAINT [DF_crm_championship_seed_history_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


