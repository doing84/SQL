USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[upd_csr_unconfirm_deal_category]    Script Date: 08/26/2016 07:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.18
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[upd_csr_unconfirm_deal_category]
@category_id	int,
@category_no	int = null,
@category_desc	varchar(50),
@register_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	if exists(select 1 from csr_unconfirm_deal_category where category_id <> @category_id and category_no = @category_no)
	begin
		raiserror('Invalid request!', 16, 1)
		return -1
	end
	
	if exists(select 1 from csr_unconfirm_deal_category where category_id = @category_id)
	begin
	update	csr_unconfirm_deal_category
	set		category_no = @category_no,
			category_desc = @category_desc,
			update_id = @register_id,
			update_date = getdate()
	where	category_id = @category_id
	end
	
	if @@ERROR <> 0 or @@ROWCOUNT = 0
	begin
	
		raiserror('enroll_customer, Updating Error', 16, 1)
		return -2
	end
	
END

