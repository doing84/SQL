USE [CEW]
GO

/****** Object:  Table [dbo].[login_postal]    Script Date: 08/29/2016 12:57:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[login_postal](
	[login_id] [int] NOT NULL,
	[postal_code] [varchar](10) NOT NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
	[update_date] [datetime] NULL,
 CONSTRAINT [PK_login_postal_code] PRIMARY KEY CLUSTERED 
(
	[login_id] ASC,
	[postal_code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[login_postal] ADD  CONSTRAINT [DF_login_postal_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[login_postal] ADD  CONSTRAINT [DF_login_postal_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


