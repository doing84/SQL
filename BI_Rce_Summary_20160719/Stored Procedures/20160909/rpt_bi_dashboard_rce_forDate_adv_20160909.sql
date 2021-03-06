USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_rce_forDate_adv]    Script Date: 09/09/2016 15:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.08.30
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_rce_forDate_adv]
@date_begin	date = null, 
@date_end	date = null
AS
BEGIN

	SET NOCOUNT ON;
	
	/*
	G = Gross
	D = Deleted
	I = Inactive
	E = Enrolled
	C = Cancelled
	*/
	
	select	--rce_type = 'G',
			rce_date = a1.sign_date,
			total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0))
	into	#total_gross
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_contract_id = a1.enroll_contract_id and
			a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	group by a1.sign_date

	select	--rce_type = 'D',
			rce_date = a1.sign_date,
			total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0))
	into	#total_deleted
	from	enroll_customer_site  a,
			enroll_customer a0,
			enroll_customer_site_contract a1
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_contract_id = a1.enroll_contract_id and
			a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
			a.enroll_site_status = 'C' and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	group by a1.sign_date

	select	--rce_type = 'I',
			rce_date = a1.sign_date,
			total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0))
	into	#total_inactive
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_contract_id = a1.enroll_contract_id and
			a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
			a0.enroll_customer_status = 'I' and
			a.enroll_site_status = 'I' and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	group by a1.sign_date
	
	select	--rce_type = 'E',
			rce_date = a1.sign_date,
			total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0))
	into	#total_enrolled
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_contract_id = a1.enroll_contract_id and
			a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
			a0.enroll_customer_status in ('X', 'I', 'U', 'C', 'D', 'Z') and
			a.enroll_site_status in ('G', 'X', 'Y') and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	group by a1.sign_date

	select	--rce_type = 'C',
			rce_date = b.cancel_date,
			total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0))
	into	#total_cancelled
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1,
			(
				select	enroll_site_id = site_id,
						cancel_date = max(cancel_date)
				from	edi_site_download
				where	status_code = 'ACR' and
						(@date_begin is null or @date_begin <= cancel_date) and
						(@date_end is null or cancel_date <= @date_end)
				group by site_id
			) b
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_site_id = a1.enroll_site_id and
			a.enroll_site_id = b.enroll_site_id and
			a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
			a0.enroll_customer_status in ('X', 'I', 'U', 'C', 'D', 'Z') and
			a.enroll_site_status = 'Z' 
	group by b.cancel_date
	
	select	a.*,
	
			total_rce_e = b.total_rce_e,
			total_rce_a = b.total_rce_a,
			
			total_rce_deleted_e = c.total_rce_e,
			total_rce_deleted_a = c.total_rce_a,
			
			total_rce_inactive_e = d.total_rce_e,
			total_rce_inactive_a = d.total_rce_a,
			
			total_rce_enrolled_e = e.total_rce_e,
			total_rce_enrolled_a = e.total_rce_a,
			
			total_rce_cancelled_e = f.total_rce_e,
			total_rce_cancelled_a = f.total_rce_a
	from	(
				select	rce_date,
						net_rce_e = sum(a.total_rce_e),
						net_rce_a = sum(a.total_rce_a)
				from	(
							select	rce_type = 'G',
									rce_date,
									total_rce_e,
									total_rce_a
							from	#total_gross
							union
							select	rce_type = 'D',
									rce_date,
									-total_rce_e,
									-total_rce_a
							from	#total_deleted
							union
							select	rce_type = 'I',
									rce_date,
									-total_rce_e,
									-total_rce_a
							from	#total_inactive
							union
							select	rce_type = 'C',
									rce_date,
									-total_rce_e,
									-total_rce_a
							from	#total_cancelled
						) a
				group by rce_date
			) a
			left outer join #total_gross b on a.rce_date = b.rce_date
			left outer join #total_deleted c on a.rce_date = c.rce_date
			left outer join #total_inactive d on a.rce_date = d.rce_date
			left outer join #total_enrolled e on a.rce_date = e.rce_date
			left outer join #total_cancelled f on a.rce_date = f.rce_date
	order by a.rce_date
	
END

