USE [CEW]
GO

/****** Object:  Table [dbo].[zone_postal]    Script Date: 08/29/2016 14:57:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[zone_postal](
	[postal_code] [varchar](10) NOT NULL,
	[postal_type] [char](1) NOT NULL,
	[postal_status] [char](1) NOT NULL,
	[zone_id] [int] NOT NULL,
	[province_id] [int] NOT NULL,
 CONSTRAINT [PK_zone_postal] PRIMARY KEY CLUSTERED 
(
	[postal_code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


