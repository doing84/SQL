USE [CEW]
GO

/****** Object:  Table [dbo].[crm_championship_status]    Script Date: 09/14/2016 07:44:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[crm_championship_status](
	[status_code] [char](1) NOT NULL,
	[status_desc] [varchar](50) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


