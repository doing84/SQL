USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_rce_forMonth]    Script Date: 08/30/2016 19:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.27
-- Description:
-- Author:		CHOI
-- Update date: 2016.08.30
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_rce_forMonth]
@date_begin		date = null, 
@date_end		date = null
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
			total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0)),
			rce_date = convert(varchar(4),datepart(year, a1.sign_date)) + '-' +
					   convert(varchar(4),datepart(month, a1.sign_date)) + '-' +
					   convert(varchar(2),datepart(wk, a1.sign_date))
	into	#total_gross
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_contract_id = a1.enroll_contract_id and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	group by convert(varchar(4),datepart(year, a1.sign_date)) + '-' +
			 convert(varchar(4),datepart(month, a1.sign_date)) + '-' +
			 convert(varchar(2),datepart(wk, a1.sign_date))
	
	select	--rce_type = 'D',
			total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0)),
			rce_date = convert(varchar(4),datepart(year, a1.sign_date)) + '-' +
					   convert(varchar(4),datepart(month, a1.sign_date)) + '-' +
					   convert(varchar(2),datepart(wk, a1.sign_date))
	into	#total_deleted
	from	enroll_customer_site  a,
			enroll_customer a0,
			enroll_customer_site_contract a1
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_contract_id = a1.enroll_contract_id and
			a.enroll_site_status = 'C' and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	group by convert(varchar(4),datepart(year, a1.sign_date)) + '-' +
			 convert(varchar(4),datepart(month, a1.sign_date)) + '-' +
			 convert(varchar(2),datepart(wk, a1.sign_date))
	
	select	--rce_type = 'I',
			total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0)),
			rce_date = convert(varchar(4),datepart(year, a1.sign_date)) + '-' +
					   convert(varchar(4),datepart(month, a1.sign_date)) + '-' +
					   convert(varchar(2),datepart(wk, a1.sign_date))
	into	#total_inactive
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_contract_id = a1.enroll_contract_id and
			a0.enroll_customer_status = 'I' and
			a.enroll_site_status = 'I' and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	group by convert(varchar(4),datepart(year, a1.sign_date)) + '-' +
			 convert(varchar(4),datepart(month, a1.sign_date)) + '-' +
			 convert(varchar(2),datepart(wk, a1.sign_date))
	
	select	--rce_type = 'E',
			total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0)),
			rce_date = convert(varchar(4),datepart(year, b.status_date)) + '-' +
					   convert(varchar(4),datepart(month, b.status_date)) + '-' +
					   convert(varchar(2),datepart(wk, b.status_date))
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
			a0.enroll_customer_status in ('X', 'I', 'U', 'C', 'D', 'Z') and
			a.enroll_site_status in ('G', 'X', 'Y') 
	group by convert(varchar(4),datepart(year, b.status_date)) + '-' +
			 convert(varchar(4),datepart(month, b.status_date)) + '-' +
			 convert(varchar(2),datepart(wk, b.status_date))
	
	select	--rce_type = 'C',
			total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0)),
			rce_date = convert(varchar(4),datepart(year, b.cancel_date)) + '-' +
					   convert(varchar(4),datepart(month, b.cancel_date)) + '-' +
			           convert(varchar(2),datepart(wk, b.cancel_date))
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
			a0.enroll_customer_status in ('X', 'I', 'U', 'C', 'D', 'Z') and
			a.enroll_site_status = 'Z'
	group by convert(varchar(4),datepart(year, b.cancel_date)) + '-' +
			 convert(varchar(4),datepart(month, b.cancel_date)) + '-' +
			 convert(varchar(2),datepart(wk, b.cancel_date))
			
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

