USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.20
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[bi_dashboard_rce_forMonth]
@date_begin		date = null, 
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;
	
	select	sign_date = a.sign_date,
			total_rce_e = isnull(a.total_rce_e, 0),
			total_rce_deleted_e = isnull(a1.total_rce_deleted_e, 0),
			total_rce_inactive_e = isnull(a2.total_rce_inactive_e, 0),
			total_rce_enrolled_e = isnull(a3.total_rce_enrolled_e, 0),
			total_rce_cancelled_e = isnull(a4.total_rce_cancelled_e, 0),
	
			total_rce_a = isnull(a.total_rce_a, 0),
			total_rce_deleted_a = isnull(a1.total_rce_deleted_a, 0),
			total_rce_inactive_a = isnull(a2.total_rce_inactive_a, 0),
			total_rce_enrolled_a = isnull(a3.total_rce_enrolled_a, 0),
			total_rce_cancelled_a = isnull(a4.total_rce_cancelled_a, 0)
	into	#bi_dashboard_rce_forMonth		
	from	(
				select	total_rce_e = sum(isnull(a.total_est_rce, 0)),
						total_rce_a = sum(isnull(a.total_rce, 0)),
						sign_date = convert(varchar(4),datepart(year, getdate())) + '-' + convert(varchar(2),datepart(month, a1.sign_date))
				from	enroll_customer_site a,
						enroll_customer a0,
						enroll_customer_site_contract a1
				where	a.enroll_customer_id = a0.enroll_customer_id and
						a.enroll_site_id = a1.enroll_site_id and			
						(@date_begin is null or @date_begin <= a1.sign_date) and
						(@date_end is null or a1.sign_date <= @date_end)
				group by convert(varchar(4),datepart(year, getdate())) + '-' + convert(varchar(2),datepart(month, a1.sign_date))
			) a 
			left outer join
			(
				select	total_rce_deleted_e = sum(isnull(a.total_est_rce, 0)),
						total_rce_deleted_a = sum(isnull(a.total_rce, 0)),
						sign_date = convert(varchar(4),datepart(year, getdate())) + '-' + convert(varchar(2),datepart(month, a1.sign_date))
				from	enroll_customer_site a,
						enroll_customer a0,
						enroll_customer_site_contract a1
				where	a.enroll_customer_id = a0.enroll_customer_id and
						a.enroll_site_id = a1.enroll_site_id and
						a.enroll_site_status = 'C' and
						(@date_begin is null or @date_begin <= a1.sign_date) and
						(@date_end is null or a1.sign_date <= @date_end)
				group by convert(varchar(4),datepart(year, getdate())) + '-' + convert(varchar(2),datepart(month, a1.sign_date))
			) a1 on a.sign_date = a1.sign_date
			left outer join
			(
				select	total_rce_inactive_e = sum(isnull(a.total_est_rce, 0)),
						total_rce_inactive_a = sum(isnull(a.total_rce, 0)),
						sign_date = convert(varchar(4),datepart(year, getdate())) + '-' + convert(varchar(2),datepart(month, a1.sign_date))
				from	enroll_customer_site a,
						enroll_customer a0,
						enroll_customer_site_contract a1
				where	a.enroll_customer_id = a0.enroll_customer_id and
						a.enroll_site_id = a1.enroll_site_id and
						a0.enroll_customer_status = 'I' and
						a.enroll_site_status = 'I' and
						(@date_begin is null or @date_begin <= a1.sign_date) and
						(@date_end is null or a1.sign_date <= @date_end)
				group by convert(varchar(4),datepart(year, getdate())) + '-' + convert(varchar(2),datepart(month, a1.sign_date))
			) a2 on a.sign_date = a2.sign_date
			left outer join
			(
				select	total_rce_enrolled_e = sum(isnull(a.total_est_rce, 0)),
						total_rce_enrolled_a = sum(isnull(a.total_rce, 0)),
						sign_date = convert(varchar(4),datepart(year, getdate())) + '-' + convert(varchar(2),datepart(month, a1.sign_date))
				from	enroll_customer_site a,
						enroll_customer a0,
						enroll_customer_site_contract a1
				where	a.enroll_customer_id = a0.enroll_customer_id and
						a.enroll_site_id = a1.enroll_site_id and
						a0.enroll_customer_status in ('X', 'I', 'U', 'C', 'D', 'Z') and
						a.enroll_site_status in ('G', 'X', 'Y') and
						(@date_begin is null or @date_begin <= a1.sign_date) and
						(@date_end is null or a1.sign_date <= @date_end)
				group by convert(varchar(4),datepart(year, getdate())) + '-' + convert(varchar(2),datepart(month, a1.sign_date))
			) a3 on a.sign_date = a3.sign_date
			left outer join
			(
				select	total_rce_cancelled_e = sum(isnull(a.total_est_rce, 0)),
						total_rce_cancelled_a = sum(isnull(a.total_rce, 0)),
						sign_date = convert(varchar(4),datepart(year, getdate())) + '-' + convert(varchar(2),datepart(month, a1.sign_date))
				from	enroll_customer_site a,
						enroll_customer a0,
						enroll_customer_site_contract a1
				where	a.enroll_customer_id = a0.enroll_customer_id and
						a.enroll_site_id = a1.enroll_site_id and
						a0.enroll_customer_status in ('X', 'I', 'U', 'C', 'D', 'Z') and
						a.enroll_site_status = 'Z' and
						(@date_begin is null or @date_begin <= a1.sign_date) and
						(@date_end is null or a1.sign_date <= @date_end)
				group by convert(varchar(4),datepart(year, getdate())) + '-' + convert(varchar(2),datepart(month, a1.sign_date))
			) a4 on a.sign_date = a4.sign_date


		select	b.*,
				net_rce_e = total_processed_e - total_rce_cancelled_e,
				net_rce_a = total_processed_a - total_rce_cancelled_a
		from	(
				select	*,
						total_processed_e = total_rce_e - (total_rce_inactive_e + total_rce_deleted_e),
						total_processed_a = total_rce_a - (total_rce_inactive_a + total_rce_deleted_a)
				from	#bi_dashboard_rce_forMonth
				) b
		order by sign_date
END


