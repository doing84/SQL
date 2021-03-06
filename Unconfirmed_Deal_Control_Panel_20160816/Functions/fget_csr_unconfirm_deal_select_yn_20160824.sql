USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_csr_unconfirm_deal_select_yn]    Script Date: 08/25/2016 14:55:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.24
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_csr_unconfirm_deal_select_yn]
(
	@enroll_customer_id	int,
	@category_no		int
)
RETURNS bit
AS
BEGIN

	DECLARE	@ResultVar bit = null
	
	select	@ResultVar = isnull(a.select_yn, 0)
	from	csr_unconfirm_deal a,
			csr_unconfirm_deal_category b
	where	a.category_id = b.category_id and
			a.customer_id = @enroll_customer_id and
			b.category_no = @category_no
			
	RETURN	@ResultVar
	
END

