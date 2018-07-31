USE [CEW]
GO

/****** Object:  Table [dbo].[contact_type]    Script Date: 07/29/2016 09:39:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[contact_type](
	[type_code] [char](1) NOT NULL,
	[type_desc] [varchar](50) NOT NULL,
 CONSTRAINT [PK_contact_type] PRIMARY KEY CLUSTERED 
(
	[type_code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


