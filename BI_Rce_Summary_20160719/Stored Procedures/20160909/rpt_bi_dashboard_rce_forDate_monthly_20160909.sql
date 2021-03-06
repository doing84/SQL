USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_rce_forDate_monthly]    Script Date: 09/09/2016 15:04:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.08.30
-- Description:		
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_rce_forDate_monthly]
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
			rce_date = left(convert(varchar, a1.sign_date, 112), 6),
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
	group by left(convert(varchar, a1.sign_date, 112), 6)

	select	--rce_type = 'D',
			rce_date = left(convert(varchar, a1.sign_date, 112), 6),
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
	group by left(convert(varchar, a1.sign_date, 112), 6)

	select	--rce_type = 'I',
			rce_date = left(convert(varchar, a1.sign_date, 112), 6),
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
	group by left(convert(varchar, a1.sign_date, 112), 6)
	
	select	--rce_type = 'E',
			rce_date = left(convert(varchar, b.status_date, 112), 6),
			total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0))
	into	#total_enrolled
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1,
			(
				select	enroll_site_id = site_id,
						status_date = max(status_date)
				from	edi_site_download
				where	status_code = 'AER' and
						(@date_begin is null or @date_begin <= status_date) and
						(@date_end is null or status_date <= @date_end)
				group by site_id
			) b 
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_contract_id = a1.enroll_contract_id and
			a.enroll_site_id = b.enroll_site_id and
			a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
			a0.enroll_customer_status in ('X', 'I', 'U', 'C', 'D', 'Z') and
			a.enroll_site_status in ('G', 'X', 'Y') 
	group by left(convert(varchar, b.status_date, 112), 6)

	select	--rce_type = 'C',
			rce_date = left(convert(varchar, b.cancel_date, 112), 6),
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
			a.enroll_contract_id = a1.enroll_contract_id and
			a.enroll_site_id = b.enroll_site_id and
			a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test where test_status = 'A') and
			a0.enroll_customer_status in ('X', 'I', 'U', 'C', 'D', 'Z') and
			a.enroll_site_status = 'Z' 
	group by left(convert(varchar, b.cancel_date, 112), 6)
	
	select	a.*,
			total_processed_e = total_rce_e - (total_rce_inactive_e + total_rce_deleted_e),
			total_processed_a = total_rce_a - (total_rce_inactive_a + total_rce_deleted_a)
	from	(
				select	a.*,
	
				total_rce_e = isnull(b.total_rce_e, 0),
				total_rce_a = isnull(b.total_rce_a, 0),
				
				total_rce_deleted_e = isnull(c.total_rce_e, 0),
				total_rce_deleted_a = isnull(c.total_rce_a, 0),
				
				total_rce_inactive_e = isnull(d.total_rce_e, 0),
				total_rce_inactive_a = isnull(d.total_rce_a, 0),
				
				total_rce_enrolled_e = isnull(e.total_rce_e, 0),
				total_rce_enrolled_a = isnull(e.total_rce_a, 0),
				
				total_rce_cancelled_e = isnull(f.total_rce_e, 0),
				total_rce_cancelled_a = isnull(f.total_rce_a, 0)
				
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
			) a	
	order by a.rce_date
	
END



