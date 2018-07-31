USE [CEW]
GO

/****** Object:  Table [dbo].[crm_championship_detail_status]    Script Date: 09/21/2016 08:57:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[crm_championship_detail_status](
	[status_code] [char](1) NOT NULL,
	[status_desc] [varchar](50) NOT NULL,
 CONSTRAINT [PK_crm_championship_detail_status] PRIMARY KEY CLUSTERED 
(
	[status_code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


