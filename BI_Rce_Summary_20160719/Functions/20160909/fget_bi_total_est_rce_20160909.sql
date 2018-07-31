USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_bi_total_est_rce]    Script Date: 09/09/2016 14:32:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.08
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_bi_total_est_rce]
(
	@login_id	int,
	@date_begin	date = null,
	@date_end	date = null
)
RETURNS float
AS
BEGIN

	DECLARE	@ResultVar float
	
	select	@ResultVar = isnull(sum(a.total_est_rce), 0)
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_contract_id = a1.enroll_contract_id and
			a.enroll_site_status not in ('C', 'Z') and
			a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
			a0.enroll_customer_status not in ('I', 'X', 'Z') and
			(a.agent_id = @login_id or a.manager_id = @login_id) and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	
	RETURN	@ResultVar
	
END

