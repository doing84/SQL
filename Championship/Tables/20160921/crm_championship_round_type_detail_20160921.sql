USE [CEW]
GO

/****** Object:  Table [dbo].[crm_championship_round_type_detail]    Script Date: 09/21/2016 08:58:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[crm_championship_round_type_detail](
	[round_id] [int] NOT NULL,
	[seed_no] [int] NOT NULL,
	[sort_seq] [int] NOT NULL,
 CONSTRAINT [PK_crm_championship_round_type_detail] PRIMARY KEY CLUSTERED 
(
	[round_id] ASC,
	[seed_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


