USE [CEW]
GO

/****** Object:  Table [dbo].[csr_unconfirm_deal_category]    Script Date: 08/25/2016 20:32:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[csr_unconfirm_deal_category](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_no] [int] NULL,
	[category_desc] [varchar](50) NOT NULL,
	[register_id] [int] NOT NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
	[update_id] [int] NULL,
	[update_date] [datetime] NULL,
 CONSTRAINT [PK_csr_unconfirm_deal_category] PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[csr_unconfirm_deal_category] ADD  CONSTRAINT [DF_csr_unconfirm_deal_category_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[csr_unconfirm_deal_category] ADD  CONSTRAINT [DF_csr_unconfirm_deal_category_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


