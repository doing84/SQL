USE [CEW]
GO

/****** Object:  Table [dbo].[company_dept]    Script Date: 07/11/2016 15:27:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[company_dept](
	[dept_id] [int] NOT NULL,
	[dept_name] [varchar](100) NOT NULL,
	[dept_email] [varchar](50) NULL,
 CONSTRAINT [PK_company_dept] PRIMARY KEY CLUSTERED 
(
	[dept_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


