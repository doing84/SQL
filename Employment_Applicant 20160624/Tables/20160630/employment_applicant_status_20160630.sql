USE [CEW]
GO

/****** Object:  Table [dbo].[employment_applicant_status]    Script Date: 06/30/2016 09:13:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[employment_applicant_status](
	[status_code] [char](1) NOT NULL,
	[status_desc] [varchar](50) NOT NULL,
	[user_friendly_desc] [varchar](100) NOT NULL,
 CONSTRAINT [PK_employment_applicant_status] PRIMARY KEY CLUSTERED 
(
	[status_code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


