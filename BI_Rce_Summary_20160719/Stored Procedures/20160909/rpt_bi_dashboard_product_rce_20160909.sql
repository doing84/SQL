USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_product_rce]    Script Date: 09/09/2016 14:55:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.09
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_product_rce] 
@date_begin		date = null,
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;

	select	a.sign_date,
			a.total_rce,
			
			hoep = isnull(b.total_rce, 0),
			fixed = isnull(c.total_rce, 0),
			intro = isnull(d.total_rce, 0)
	into	#rpt_bi_product
	from	(			
				select	b.sign_date,
						total_rce = sum(a.total_rce)
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
						total_rce = sum(a.total_rce)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.enroll_site_status not in ('C', 'Z') and
						a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
						b.item_type = 'H' and
						(@date_begin is null or @date_begin <= sign_date) and
						(@date_end is null or sign_date <= @date_end)
				group by b.sign_date
			) b on a.sign_date = b.sign_date
			left outer join
			(	
				select	b.sign_date,
						total_rce = sum(a.total_rce)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.enroll_site_status not in ('C', 'Z') and
						a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
						b.item_type = 'F' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by b.sign_date
			) c on a.sign_date = c.sign_date
			left outer join
			(	
				select	b.sign_date,
						total_rce = sum(a.total_rce)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.enroll_site_status not in ('C', 'Z') and
						a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
						b.item_type = 'I' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by b.sign_date
			) d on a.sign_date = d.sign_date

	select	hoep = sum(hoep), 
			fixed = sum(fixed), 
			intro = sum(intro)
	from	#rpt_bi_product
	
END

