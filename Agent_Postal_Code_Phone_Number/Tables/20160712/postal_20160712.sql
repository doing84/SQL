USE [CEW]
GO

/****** Object:  Table [dbo].[postal]    Script Date: 07/12/2016 17:26:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[postal](
	[postal_code] [varchar](10) NOT NULL,
	[postal_type] [char](1) NOT NULL,
	[postal_status] [char](1) NOT NULL,
	[zone_id] [int] NOT NULL,
 CONSTRAINT [PK_postal] PRIMARY KEY CLUSTERED 
(
	[postal_code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[postal] ADD  CONSTRAINT [DF_postal_postal_status]  DEFAULT ('A') FOR [postal_status]
GO


