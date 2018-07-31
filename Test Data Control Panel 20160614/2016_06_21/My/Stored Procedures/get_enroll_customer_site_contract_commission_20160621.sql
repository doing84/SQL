USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_edi_site_history3]    Script Date: 06/21/2016 13:18:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.21
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_enroll_customer_site_contract_commission_list]
@enroll_site_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.enroll_contract_id,
			a.commission_status,
			a.commission_type,
			a.commission_amount,
			c.full_name
	from	enroll_customer_site_contract_commission a
			inner join enroll_customer_site_contract b on a.enroll_contract_id = b.enroll_contract_id
			inner join [login] c on b.enroll_login_id = c.login_id 
	where	b.enroll_site_id = @enroll_site_id		
	
END


