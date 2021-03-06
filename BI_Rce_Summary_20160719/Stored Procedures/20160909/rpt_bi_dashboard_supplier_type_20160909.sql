USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_supplier_type]    Script Date: 09/09/2016 15:10:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.09
-- Description:	
-- Author:		CHOI
-- Update date: 2016.09.09
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_supplier_type]
@date_begin		date = null,
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;

	select	a.sign_date,
			a.total_count,
			
			gas = isnull(b.total_count, 0),
			electric = isnull(c.total_count, 0)
	into	#rpt_bi_supplier_type
	from	(			
				select	b.sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.enroll_site_status not in ('C', 'Z') and
						a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by b.sign_date
			) a
			left outer join
			(	
				select	b.sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.enroll_site_status not in ('C', 'Z') and
						a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
						a.supplier_type = 'G' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by b.sign_date
			) b on a.sign_date = b.sign_date
			left outer join
			(	
				select	b.sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.enroll_site_status not in ('C', 'Z') and
						a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
						a.supplier_type = 'E' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by b.sign_date
			) c	on a.sign_date = c.sign_date
			
	select	gas = sum(gas),
			electric = sum(electric)
	from	#rpt_bi_supplier_type
		
END

