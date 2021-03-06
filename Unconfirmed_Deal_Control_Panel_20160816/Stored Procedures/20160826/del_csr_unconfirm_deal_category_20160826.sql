USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[del_csr_unconfirm_deal_category]    Script Date: 08/26/2016 19:07:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.18
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[del_csr_unconfirm_deal_category]
@category_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	if exists(select 1 from csr_unconfirm_deal where category_id = @category_id)
	begin
		raiserror('Error, this record is locked!', 16, 1)
		return -1
	end
		
	delete
	from	csr_unconfirm_deal_category
	where	category_id = @category_id
	
	if @@ERROR <> 0 or @@ROWCOUNT = 0
	begin
		raiserror('Invalid request!', 16, 1)
		return -1
	end

END

