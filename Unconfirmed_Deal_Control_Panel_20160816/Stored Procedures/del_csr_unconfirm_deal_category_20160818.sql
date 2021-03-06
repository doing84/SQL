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
CREATE PROCEDURE [dbo].[del_csr_unconfirm_deal_category]
@category_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	delete
	from	csr_unconfirm_deal_category
	where	category_id = @category_id
	
	if @@ERROR <> 0 or @@ROWCOUNT = 0
	begin
		raiserror('Invalid request!', 16, 1)
		return -1
	end

END


