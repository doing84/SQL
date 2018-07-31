USE [CEW]
GO

/****** Object:  Table [dbo].[crm_championship_detail]    Script Date: 09/15/2016 20:30:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[crm_championship_detail](
	[detail_id] [int] IDENTITY(1,1) NOT NULL,
	[championship_id] [int] NOT NULL,
	[round_id] [int] NULL,
	[round_status] [char](1) NOT NULL,
	[snapshot_id] [int] NULL,
	[detail_date] [date] NOT NULL,
	[detail_status] [char](1) NOT NULL,
	[date_yn] [bit] NOT NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
	[update_date] [datetime] NULL,
 CONSTRAINT [PK_crm_championship_detail] PRIMARY KEY CLUSTERED 
(
	[detail_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[crm_championship_detail] ADD  CONSTRAINT [DF_crm_championship_detail_round_status]  DEFAULT ('I') FOR [round_status]
GO

ALTER TABLE [dbo].[crm_championship_detail] ADD  CONSTRAINT [DF_crm_championship_detail_detail_status]  DEFAULT ('I') FOR [detail_status]
GO

ALTER TABLE [dbo].[crm_championship_detail] ADD  CONSTRAINT [DF_crm_championship_detail_date_status]  DEFAULT ((1)) FOR [date_yn]
GO

ALTER TABLE [dbo].[crm_championship_detail] ADD  CONSTRAINT [DF_crm_championship_detail_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[crm_championship_detail] ADD  CONSTRAINT [DF_crm_championship_detail_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


