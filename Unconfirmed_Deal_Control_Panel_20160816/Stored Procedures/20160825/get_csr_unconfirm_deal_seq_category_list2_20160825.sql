USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_csr_unconfirm_deal_seq_category_list2]    Script Date: 08/26/2016 07:54:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.18
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_csr_unconfirm_deal_seq_category_list2]
@enroll_customer_id	int
AS
BEGIN
	
	SET NOCOUNT ON;

	select	a.*,
			select_yn = isnull(b.select_yn, 0)
	from	csr_unconfirm_deal_category a
			left outer join csr_unconfirm_deal b on a.category_id = b.category_id and b.customer_id = @enroll_customer_id
	where	(a.category_no between 1 and 6)

END

