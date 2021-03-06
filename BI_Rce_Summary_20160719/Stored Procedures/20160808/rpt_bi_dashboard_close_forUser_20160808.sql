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
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_close_forUser]
@login_type	char(1) = null,
@date_begin	date = null,
@date_end	date = null
AS
BEGIN

	SET NOCOUNT ON;
	
	if @login_type = 'S'
	begin

		select	top 3 a1.login_id,
				login_full_name = a1.full_name,
				a.total_appt,
				--total_appt_cancelled_agent = isnull(a2.total_appt_cancelled_agent, 0),
				--total_appt_cancelled_customer = isnull(a3.total_appt_cancelled_customer, 0),
				--total_appt_not_interested = isnull(a4.total_appt_not_interested, 0),
				--total_customer = isnull(b.total_customer, 0),
				--total_customer_confirmed_ldc = isnull(b1.total_customer_confirmed_ldc, 0),
				--total_customer_confirmed_customer = isnull(b2.total_customer_confirmed_customer, 0),
				--total_customer_confirmed_tpv = isnull(b3.total_customer_confirmed_tpv, 0),
				--total_site = isnull(c.total_site, 0),
				--total_site_enrolled = isnull(c1.total_site_enrolled, 0),
				rate_customer_appt = (isnull(b.total_customer, 0) / convert(float, a.total_appt)) * 100.00
		from	(
					select	login_id,
							total_appt = count(detail_id)
					from	crm_call_detail
					where	login_id is not null and
							(@date_begin is null or @date_begin <= register_date) and
							(@date_end is null or register_date <= @date_end)
					group by login_id
				) a
				inner join [login] a1 on a.login_id = a1.login_id
				left outer join
				(
					select	login_id,
							total_appt_cancelled_agent = count(detail_id)
					from	crm_call_detail
					where	login_id is not null and
							detail_status = 'C' and
							(@date_begin is null or @date_begin <= register_date) and
							(@date_end is null or register_date <= @date_end)
					group by login_id
				) a2 on a.login_id = a2.login_id
				left outer join
				(
					select	login_id,
							total_appt_cancelled_customer = count(detail_id)
					from	crm_call_detail
					where	login_id is not null and
							detail_status = 'X' and
							(@date_begin is null or @date_begin <= register_date) and
							(@date_end is null or register_date <= @date_end)
					group by login_id
				) a3 on a.login_id = a3.login_id
				left outer join
				(
					select	login_id,
							total_appt_not_interested = count(detail_id)
					from	crm_call_detail
					where	login_id is not null and
							detail_status = 'N' and
							(@date_begin is null or @date_begin <= register_date) and
							(@date_end is null or register_date <= @date_end)
					group by login_id
				) a4 on a.login_id = a4.login_id
				----------------------------------------------------------------------
				left outer join
				(
					select	a.login_id,
							total_customer = count(b.enroll_customer_id)
					from	crm_call_detail a,
							enroll_customer b
					where	a.detail_id = b.crm_call_detail_id and
							a.login_id is not null and
							b.enroll_customer_status <> 'Z' and
							(@date_begin is null or @date_begin <= a.register_date) and
							(@date_end is null or a.register_date <= @date_end)
					group by a.login_id
				) b on a.login_id = b.login_id
				left outer join
				(
					select	a.login_id,
							total_customer_confirmed_ldc = count(b.enroll_customer_id)
					from	crm_call_detail a,
							enroll_customer b
					where	a.detail_id = b.crm_call_detail_id and
							a.login_id is not null and
							b.enroll_customer_status = 'D' and
							(@date_begin is null or @date_begin <= a.register_date) and
							(@date_end is null or a.register_date <= @date_end)
					group by a.login_id
				) b1 on a.login_id = b1.login_id
				left outer join
				(
					select	a.login_id,
							total_customer_confirmed_customer = count(b.enroll_customer_id)
					from	crm_call_detail a,
							enroll_customer b
					where	a.detail_id = b.crm_call_detail_id and
							a.login_id is not null and
							b.enroll_customer_status = 'C' and
							(@date_begin is null or @date_begin <= a.register_date) and
							(@date_end is null or a.register_date <= @date_end)
					group by a.login_id
				) b2 on a.login_id = b2.login_id
				left outer join
				(
					select	a.login_id,
							total_customer_confirmed_tpv = count(b.enroll_customer_id)
					from	crm_call_detail a,
							enroll_customer b
					where	a.detail_id = b.crm_call_detail_id and
							a.login_id is not null and
							b.enroll_customer_status = 'U' and
							(@date_begin is null or @date_begin <= a.register_date) and
							(@date_end is null or a.register_date <= @date_end)
					group by a.login_id
				) b3 on a.login_id = b3.login_id
				----------------------------------------------------------------------
				left outer join
				(
					select	a.login_id,
							total_site = count(c.enroll_site_id)
					from	crm_call_detail a,
							enroll_customer b,
							enroll_customer_site c
					where	a.detail_id = b.crm_call_detail_id and
							b.enroll_customer_id = c.enroll_customer_id and
							a.login_id is not null and
							c.enroll_site_status <> 'C' and
							(@date_begin is null or @date_begin <= a.register_date) and
							(@date_end is null or a.register_date <= @date_end)
					group by a.login_id
				) c on a.login_id = c.login_id
				left outer join
				(
					select	a.login_id,
							total_site_enrolled = count(c.enroll_site_id)
					from	crm_call_detail a,
							enroll_customer b,
							enroll_customer_site c
					where	a.detail_id = b.crm_call_detail_id and
							b.enroll_customer_id = c.enroll_customer_id and
							a.login_id is not null and
							c.enroll_site_status in ('G', 'X', 'Y') and
							(@date_begin is null or @date_begin <= a.register_date) and
							(@date_end is null or a.register_date <= @date_end)
					group by a.login_id
				) c1 on a.login_id = c1.login_id
		order by a1.full_name
	
	end
	else
	begin
	
		select	top 4 a1.login_id,
				login_full_name = a1.full_name,
				a.total_appt,
				--total_appt_cancelled_agent = isnull(a2.total_appt_cancelled_agent, 0),
				--total_appt_cancelled_customer = isnull(a3.total_appt_cancelled_customer, 0),
				--total_appt_not_interested = isnull(a4.total_appt_not_interested, 0),
				--total_customer = isnull(b.total_customer, 0),
				--total_customer_confirmed_ldc = isnull(b1.total_customer_confirmed_ldc, 0),
				--total_customer_confirmed_customer = isnull(b2.total_customer_confirmed_customer, 0),
				--total_customer_confirmed_tpv = isnull(b3.total_customer_confirmed_tpv, 0),
				--total_site = isnull(c.total_site, 0),
				--total_site_enrolled = isnull(c1.total_site_enrolled, 0),
				rate_customer_appt = (isnull(b.total_customer, 0) / convert(float, a.total_appt)) * 100.00
		from	(
					select	register_id,
							total_appt = count(detail_id)
					from	crm_call_detail
					where	(@date_begin is null or @date_begin <= register_date) and
							(@date_end is null or register_date <= @date_end)
					group by register_id
				) a
				inner join [login] a1 on a.register_id = a1.login_id
				left outer join
				(
					select	register_id,
							total_appt_cancelled_agent = count(detail_id)
					from	crm_call_detail
					where	detail_status = 'C' and
							(@date_begin is null or @date_begin <= register_date) and
							(@date_end is null or register_date <= @date_end)
					group by register_id
				) a2 on a.register_id = a2.register_id
				left outer join
				(
					select	register_id,
							total_appt_cancelled_customer = count(detail_id)
					from	crm_call_detail
					where	detail_status = 'X' and
							(@date_begin is null or @date_begin <= register_date) and
							(@date_end is null or register_date <= @date_end)
					group by register_id
				) a3 on a.register_id = a3.register_id
				left outer join
				(
					select	register_id,
							total_appt_not_interested = count(detail_id)
					from	crm_call_detail
					where	detail_status = 'N' and
							(@date_begin is null or @date_begin <= register_date) and
							(@date_end is null or register_date <= @date_end)
					group by register_id
				) a4 on a.register_id = a4.register_id
				----------------------------------------------------------------------
				left outer join
				(
					select	a.register_id,
							total_customer = count(b.enroll_customer_id)
					from	crm_call_detail a,
							enroll_customer b
					where	a.detail_id = b.crm_call_detail_id and
							b.enroll_customer_status <> 'Z' and
							(@date_begin is null or @date_begin <= a.register_date) and
							(@date_end is null or a.register_date <= @date_end)
					group by a.register_id
				) b on a.register_id = b.register_id
				left outer join
				(
					select	a.register_id,
							total_customer_confirmed_ldc = count(b.enroll_customer_id)
					from	crm_call_detail a,
							enroll_customer b
					where	a.detail_id = b.crm_call_detail_id and
							b.enroll_customer_status = 'D' and
							(@date_begin is null or @date_begin <= a.register_date) and
							(@date_end is null or a.register_date <= @date_end)
					group by a.register_id
				) b1 on a.register_id = b1.register_id
				left outer join
				(
					select	a.register_id,
							total_customer_confirmed_customer = count(b.enroll_customer_id)
					from	crm_call_detail a,
							enroll_customer b
					where	a.detail_id = b.crm_call_detail_id and
							b.enroll_customer_status = 'C' and
							(@date_begin is null or @date_begin <= a.register_date) and
							(@date_end is null or a.register_date <= @date_end)
					group by a.register_id
				) b2 on a.register_id = b2.register_id
				left outer join
				(
					select	a.register_id,
							total_customer_confirmed_tpv = count(b.enroll_customer_id)
					from	crm_call_detail a,
							enroll_customer b
					where	a.detail_id = b.crm_call_detail_id and
							b.enroll_customer_status = 'U' and
							(@date_begin is null or @date_begin <= a.register_date) and
							(@date_end is null or a.register_date <= @date_end)
					group by a.register_id
				) b3 on a.register_id = b3.register_id
				----------------------------------------------------------------------
				left outer join
				(
					select	a.register_id,
							total_site = count(c.enroll_site_id)
					from	crm_call_detail a,
							enroll_customer b,
							enroll_customer_site c
					where	a.detail_id = b.crm_call_detail_id and
							b.enroll_customer_id = c.enroll_customer_id and
							c.enroll_site_status <> 'C' and
							(@date_begin is null or @date_begin <= a.register_date) and
							(@date_end is null or a.register_date <= @date_end)
					group by a.register_id
				) c on a.register_id = c.register_id
				left outer join
				(
					select	a.register_id,
							total_site_enrolled = count(c.enroll_site_id)
					from	crm_call_detail a,
							enroll_customer b,
							enroll_customer_site c
					where	a.detail_id = b.crm_call_detail_id and
							b.enroll_customer_id = c.enroll_customer_id and
							c.enroll_site_status in ('G', 'X', 'Y') and
							(@date_begin is null or @date_begin <= a.register_date) and
							(@date_end is null or a.register_date <= @date_end)
					group by a.register_id
				) c1 on a.register_id = c1.register_id
		order by a1.full_name
	
	end
	
END

