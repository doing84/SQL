USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_csr_unconfirm_deal_category]    Script Date: 08/26/2016 19:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.18
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_csr_unconfirm_deal_category] 
@category_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	category_id,
			category_no,
			category_desc
	from	csr_unconfirm_deal_category
	where	category_id = @category_id
	
END

