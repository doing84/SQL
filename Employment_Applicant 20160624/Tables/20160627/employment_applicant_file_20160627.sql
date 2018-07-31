USE [CEW]
GO

/****** Object:  Table [dbo].[employment_applicant_file]    Script Date: 06/27/2016 08:09:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[employment_applicant_file](
	[file_id] [int] IDENTITY(1,1) NOT NULL,
	[file_name] [varchar](50) NOT NULL,
	[file_note] [varchar](100) NOT NULL,
	[register_id] [int] NOT NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
	[update_date] [datetime] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


