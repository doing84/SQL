USE [CEW]
GO

/****** Object:  Table [dbo].[crm_championship_seed]    Script Date: 09/21/2016 08:58:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[crm_championship_seed](
	[seed_id] [int] IDENTITY(1,1) NOT NULL,
	[seed_status] [char](1) NOT NULL,
	[detail_id] [int] NOT NULL,
	[login_id] [int] NULL,
	[seed_no] [int] NULL,
	[register_id] [int] NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
	[update_date] [datetime] NULL,
 CONSTRAINT [PK_crm_championship_seed] PRIMARY KEY CLUSTERED 
(
	[seed_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[crm_championship_seed] ADD  CONSTRAINT [DF_crm_championship_seed_seed_status]  DEFAULT ('I') FOR [seed_status]
GO

ALTER TABLE [dbo].[crm_championship_seed] ADD  CONSTRAINT [DF_crm_championship_seed_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[crm_championship_seed] ADD  CONSTRAINT [DF_crm_championship_seed_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


