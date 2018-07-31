USE [CEW]
GO

/****** Object:  Table [dbo].[crm_championship_detail_status]    Script Date: 09/19/2016 08:26:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[crm_championship_detail_status](
	[status_code] [char](1) NOT NULL,
	[status_desc] [varchar](50) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


