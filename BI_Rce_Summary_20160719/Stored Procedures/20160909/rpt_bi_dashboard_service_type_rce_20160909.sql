USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_service_type]    Script Date: 09/09/2016 11:47:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.09
-- Description:
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_service_type_rce]
@date_begin		date = null,
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;

	select	a.sign_date,
			a.total_rce,
			
			sv = isnull(b.total_rce, 0),
			lv = isnull(c.total_rce, 0)
	into	#rpt_bi_service_type
	from	(			
				select	sign_date,
						total_rce = sum(a.total_rce)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.enroll_site_status not in ('C', 'Z') and
						a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by sign_date
			) a
			left outer join
			(	
				select	sign_date,
						total_rce = sum(a.total_rce)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.enroll_site_status not in ('C', 'Z') and
						a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
						a.service_type in ('S', 'R') and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by sign_date
			) b on a.sign_date = b.sign_date
			left outer join
			(	
				select	sign_date,
						total_rce = sum(a.total_rce)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.enroll_site_status not in ('C', 'Z') and
						a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
						a.service_type = 'L' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by sign_date
			) c	on a.sign_date = c.sign_date

	select	sv = sum(sv),
			lv = sum(lv)
	from	#rpt_bi_service_type
	where	sign_date between @date_begin and @date_end

END

