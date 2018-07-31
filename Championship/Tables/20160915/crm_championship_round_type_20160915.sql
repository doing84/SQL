USE [CEW]
GO

/****** Object:  Table [dbo].[crm_championship_round_type]    Script Date: 09/15/2016 07:29:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[crm_championship_round_type](
	[round_id] [int] NOT NULL,
	[sort_seq] [int] NOT NULL,
	[round_desc] [varchar](50) NOT NULL,
	[min_player] [int] NOT NULL,
 CONSTRAINT [PK_crm_championship_round_type] PRIMARY KEY CLUSTERED 
(
	[round_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


