USE [CEW]
GO

/****** Object:  Table [dbo].[crm_championship_note]    Script Date: 09/15/2016 20:31:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[crm_championship_note](
	[note_id] [int] IDENTITY(1,1) NOT NULL,
	[note_desc] [varchar](200) NOT NULL,
	[detail_id] [int] NOT NULL,
	[register_id] [int] NOT NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
 CONSTRAINT [PK_crm_championship_note] PRIMARY KEY CLUSTERED 
(
	[note_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[crm_championship_note] ADD  CONSTRAINT [DF_crm_championship_note_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[crm_championship_note] ADD  CONSTRAINT [DF_crm_championship_note_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


