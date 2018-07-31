USE [CEW]
GO

/****** Object:  Table [dbo].[contact_email_type]    Script Date: 07/26/2016 15:39:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[contact_email_type](
	[type_code] [char](1) NOT NULL,
	[type_desc] [varchar](50) NOT NULL,
 CONSTRAINT [PK_contact_email_type] PRIMARY KEY CLUSTERED 
(
	[type_code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


