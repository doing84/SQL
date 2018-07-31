USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.08
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_appointment]
@date_begin		date = null,
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.register_date,
			a.total_appt,
			--total_appt_cancelled_agent = isnull(a1.total_appt_cancelled_agent, 0),
			--total_appt_cancelled_customer = isnull(a2.total_appt_cancelled_customer, 0),
			--total_appt_not_interested = isnull(a3.total_appt_not_interested, 0),
			--total_customer = isnull(b.total_customer, 0),
			--total_customer_confirmed_ldc = isnull(b1.total_customer_confirmed_ldc, 0),
			--total_customer_confirmed_customer = isnull(b2.total_customer_confirmed_customer, 0),
			--total_customer_confirmed_tpv = isnull(b3.total_customer_confirmed_tpv, 0),
			--total_site = isnull(c.total_site, 0),
			--total_site_enrolled = isnull(c1.total_site_enrolled, 0),
			rate_customer_appt = (isnull(b.total_customer, 0) / convert(float, a.total_appt)) * 100.00
	from	(
				select	register_date,
						total_appt = count(detail_id)
				from	crm_call_detail
				where	(@date_begin is null or @date_begin <= register_date) and
						(@date_end is null or register_date <= @date_end)
				group by register_date
			) a
			left outer join
			(
				select	register_date,
						total_appt_cancelled_agent = count(detail_id)
				from	crm_call_detail
				where	detail_status = 'C' and
						(@date_begin is null or @date_begin <= register_date) and
						(@date_end is null or register_date <= @date_end)
				group by register_date
			) a1 on a.register_date = a1.register_date
			left outer join
			(
				select	register_date,
						total_appt_cancelled_customer = count(detail_id)
				from	crm_call_detail
				where	detail_status = 'X' and
						(@date_begin is null or @date_begin <= register_date) and
						(@date_end is null or register_date <= @date_end)
				group by register_date
			) a2 on a.register_date = a2.register_date
			left outer join
			(
				select	register_date,
						total_appt_not_interested = count(detail_id)
				from	crm_call_detail
				where	detail_status = 'N' and
						(@date_begin is null or @date_begin <= register_date) and
						(@date_end is null or register_date <= @date_end)
				group by register_date
			) a3 on a.register_date = a3.register_date
			----------------------------------------------------------------------
			left outer join
			(
				select	a.register_date,
						total_customer = count(b.enroll_customer_id)
				from	crm_call_detail a,
						enroll_customer b
				where	a.detail_id = b.crm_call_detail_id and
						b.enroll_customer_status <> 'Z' and
						(@date_begin is null or @date_begin <= a.register_date) and
						(@date_end is null or a.register_date <= @date_end)
				group by a.register_date
			) b on a.register_date = b.register_date
			left outer join
			(
				select	a.register_date,
						total_customer_confirmed_ldc = count(b.enroll_customer_id)
				from	crm_call_detail a,
						enroll_customer b
				where	a.detail_id = b.crm_call_detail_id and
						b.enroll_customer_status = 'D' and
						(@date_begin is null or @date_begin <= a.register_date) and
						(@date_end is null or a.register_date <= @date_end)
				group by a.register_date
			) b1 on a.register_date = b1.register_date
			left outer join
			(
				select	a.register_date,
						total_customer_confirmed_customer = count(b.enroll_customer_id)
				from	crm_call_detail a,
						enroll_customer b
				where	a.detail_id = b.crm_call_detail_id and
						b.enroll_customer_status = 'C' and
						(@date_begin is null or @date_begin <= a.register_date) and
						(@date_end is null or a.register_date <= @date_end)
				group by a.register_date
			) b2 on a.register_date = b2.register_date
			left outer join
			(
				select	a.register_date,
						total_customer_confirmed_tpv = count(b.enroll_customer_id)
				from	crm_call_detail a,
						enroll_customer b
				where	a.detail_id = b.crm_call_detail_id and
						b.enroll_customer_status = 'U' and
						(@date_begin is null or @date_begin <= a.register_date) and
						(@date_end is null or a.register_date <= @date_end)
				group by a.register_date
			) b3 on a.register_date = b3.register_date
			----------------------------------------------------------------------
			left outer join
			(
				select	a.register_date,
						total_site = count(c.enroll_site_id)
				from	crm_call_detail a,
						enroll_customer b,
						enroll_customer_site c
				where	a.detail_id = b.crm_call_detail_id and
						b.enroll_customer_id = c.enroll_customer_id and
						c.enroll_site_status <> 'C' and
						(@date_begin is null or @date_begin <= a.register_date) and
						(@date_end is null or a.register_date <= @date_end)
				group by a.register_date
			) c on a.register_date = c.register_date
			left outer join
			(
				select	a.register_date,
						total_site_enrolled = count(c.enroll_site_id)
				from	crm_call_detail a,
						enroll_customer b,
						enroll_customer_site c
				where	a.detail_id = b.crm_call_detail_id and
						b.enroll_customer_id = c.enroll_customer_id and
						c.enroll_site_status in ('G', 'X', 'Y') and
						(@date_begin is null or @date_begin <= a.register_date) and
						(@date_end is null or a.register_date <= @date_end)
				group by a.register_date
			) c1 on a.register_date = c1.register_date
	order by a.register_date
	
END


