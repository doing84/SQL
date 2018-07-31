USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.18
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[get_csr_unconfirm_deal_seq_category_list]
AS
DECLARE
@category1 varchar(50),
@category2 varchar(50),
@category3 varchar(50),
@category4 varchar(50),
@category5 varchar(50),
@category6 varchar(50)
BEGIN

	SET NOCOUNT ON;
	select	@category1 = category_desc
	from	csr_unconfirm_deal_category
	where	category_no between 1 and 6 and
			category_no = 1
			
	select	@category2 = category_desc
	from	csr_unconfirm_deal_category
	where	category_no between 1 and 6 and
			category_no = 2
	
	select	@category3 = category_desc
	from	csr_unconfirm_deal_category
	where	category_no between 1 and 6 and
			category_no = 3	
	
	select	@category4 = category_desc
	from	csr_unconfirm_deal_category
	where	category_no between 1 and 6 and
			category_no = 4	
	
	select	@category5 = category_desc
	from	csr_unconfirm_deal_category
	where	category_no between 1 and 6 and
			category_no = 5	
			
	select	@category6 = category_desc
	from	csr_unconfirm_deal_category
	where	category_no between 1 and 6 and
			category_no = 6			
	
	select  category1 = @category1,
			category2 = @category2,
			category3 = @category3,
			category4 = @category4,
			category5 = @category5,
			category6 = @category6
					
END

