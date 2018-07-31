USE [CEW]
GO

/****** Object:  Table [dbo].[contact_response]    Script Date: 07/22/2016 08:00:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[contact_response](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[contact_id] [int] NOT NULL,
	[login_id] [int] NOT NULL,
	[contact_name] [varchar](100) NOT NULL,
	[contact_email] [varchar](50) NOT NULL,
	[contact_phone] [varchar](20) NULL,
	[log_desc] [varchar](1000) NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
 CONSTRAINT [PK_contact_response] PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[contact_response] ADD  CONSTRAINT [DF_contact_response_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[contact_response] ADD  CONSTRAINT [DF_contact_response_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


