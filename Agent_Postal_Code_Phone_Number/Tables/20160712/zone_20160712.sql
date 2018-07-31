USE [CEW]
GO

/****** Object:  Table [dbo].[zone]    Script Date: 07/12/2016 17:27:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[zone](
	[zone_id] [int] NOT NULL,
	[zone_status] [char](1) NOT NULL,
	[zone_desc] [varchar](50) NOT NULL,
	[country_id] [int] NOT NULL,
	[province_id] [int] NOT NULL,
	[sort_seq] [int] NOT NULL,
 CONSTRAINT [PK_zone] PRIMARY KEY CLUSTERED 
(
	[zone_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[zone] ADD  CONSTRAINT [DF_zone_zone_status]  DEFAULT ('A') FOR [zone_status]
GO

ALTER TABLE [dbo].[zone] ADD  CONSTRAINT [DF_zone_sort_seq]  DEFAULT ((0)) FOR [sort_seq]
GO


