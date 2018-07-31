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
CREATE PROCEDURE [dbo].[get_csr_unconfirm_deal_category] 
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

