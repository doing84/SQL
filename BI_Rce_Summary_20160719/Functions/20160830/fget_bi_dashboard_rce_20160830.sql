USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_agent_production_act_rce_summary]    Script Date: 08/30/2016 13:28:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.30
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_bi_dashboard_rce]
(
	@login_id	int,
	@date_begin	date,
	@date_end	date
)
RETURNS float
AS
BEGIN

	DECLARE	@ResultVar float
	
	select	@ResultVar = sum(b.total_rce)
	from	enroll_customer a,
			enroll_customer_site b,
			enroll_customer_site_contract c
	where	a.enroll_customer_id = b.enroll_customer_id and
			b.enroll_contract_id = c.enroll_contract_id and
			a.enroll_customer_status <> 'Z' and
			b.enroll_site_status <> 'C' and
			b.total_rce is not null and
			(
				b.agent_id = @login_id or
				b.manager_id = @login_id and
				(@date_begin is null or @date_begin <= c.sign_date) and
				(@date_end is null or c.sign_date <= @date_end)
			)
		RETURN	@ResultVar
	
END

