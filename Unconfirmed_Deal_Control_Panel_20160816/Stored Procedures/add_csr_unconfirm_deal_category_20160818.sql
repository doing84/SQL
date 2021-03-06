USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[add_csr_unconfirm_deal_category]    Script Date: 08/18/2016 17:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.18
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_csr_unconfirm_deal_category]
@category_no		int = null,
@category_desc		varchar(50),
@register_id		int
AS
BEGIN

	SET NOCOUNT ON;
	
	if exists(select 1 from csr_unconfirm_deal_category where category_no = @category_no)
	begin
		raiserror('Invalid request!', 16, 1)
		return -1
	end
	
	insert into csr_unconfirm_deal_category
	(
		category_no,
		category_desc,
		register_id	
	)
	values
	(	
		@category_no,
		@category_desc,
		@register_id	
	)
	
END

