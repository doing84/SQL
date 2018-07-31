USE [CEW]
GO

/****** Object:  Table [dbo].[csr_unconfirm_deal]    Script Date: 08/26/2016 19:01:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[csr_unconfirm_deal](
	[customer_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
	[select_yn] [bit] NOT NULL,
	[register_id] [int] NOT NULL,
	[register_date] [date] NOT NULL,
	[register_time] [time](7) NOT NULL,
	[update_id] [int] NULL,
	[update_date] [datetime] NULL,
 CONSTRAINT [PK_csr_unconfirm_deal] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC,
	[category_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[csr_unconfirm_deal] ADD  CONSTRAINT [DF_csr_unconfirm_deal_select_yn]  DEFAULT ((0)) FOR [select_yn]
GO

ALTER TABLE [dbo].[csr_unconfirm_deal] ADD  CONSTRAINT [DF_csr_unconfirm_deal_register_id]  DEFAULT ((0)) FOR [register_id]
GO

ALTER TABLE [dbo].[csr_unconfirm_deal] ADD  CONSTRAINT [DF_csr_unconfirm_deal_register_date]  DEFAULT (getdate()) FOR [register_date]
GO

ALTER TABLE [dbo].[csr_unconfirm_deal] ADD  CONSTRAINT [DF_csr_unconfirm_deal_register_time]  DEFAULT (getdate()) FOR [register_time]
GO


