USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.24
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_csr_unconfirm_deal_call_list]
@enroll_customer_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.*,
			call_type_desc = a1.type_desc,
			register_full_name = b.full_name,
			call_category_desc = c.call_category_desc,
			call_category_detail_desc = d.call_category_detail_desc
	from	csr_call a
			inner join csr_call_type a1 on a.call_type = a1.type_code 
			inner join [login] b on a.register_id = b.login_id
			inner join csr_call_category c on a.call_category_id = c.call_category_id
			left outer join csr_call_category_detail d on a.call_category_detail_id = d.call_category_detail_id
	where	a.enroll_customer_id = @enroll_customer_id 
			
END

