USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[upd_csr_unconfirm_deal2]    Script Date: 08/26/2016 07:57:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.25
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[upd_csr_unconfirm_deal2]
@enroll_customer_id	int,
@category_id		int,
@select_yn			bit,
@register_id		int
AS
BEGIN

	SET NOCOUNT ON;
	
	update	csr_unconfirm_deal
	set		customer_id = @enroll_customer_id, 	
			category_id = @category_id,	
			select_yn = @select_yn,	
			update_id = @register_id,	
			update_date = getdate()	
	where	customer_id = @enroll_customer_id
	
END

