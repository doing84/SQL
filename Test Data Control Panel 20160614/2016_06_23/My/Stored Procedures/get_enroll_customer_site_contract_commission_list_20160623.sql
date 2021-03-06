USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_enroll_customer_site_contract_commission_list]    Script Date: 06/23/2016 15:49:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.21
-- Description:	
--
-- Update:		SKC
-- UPdate date: 2016.06.22
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_enroll_customer_site_contract_commission_list]
@enroll_site_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	/*
	select	a.enroll_contract_id,
			a.commission_status,
			a.commission_type,
			a.commission_amount,
			c.full_name
	from	enroll_customer_site_contract_commission a
			inner join enroll_customer_site_contract b on a.enroll_contract_id = b.enroll_contract_id
			inner join [login] c on b.enroll_login_id = c.login_id 
	where	b.enroll_site_id = @enroll_site_id		
	*/
	
	select	a.enroll_contract_id,
			b.commission_status,
			b.commission_type,
			b.commission_amount,
			c.full_name
	from	enroll_customer_site_contract a
			inner join enroll_customer_site_contract_commission b on a.enroll_contract_id = b.enroll_contract_id
			left outer join [login] c on b.login_id = c.login_id
	where	a.enroll_site_id = @enroll_site_id
	
END


