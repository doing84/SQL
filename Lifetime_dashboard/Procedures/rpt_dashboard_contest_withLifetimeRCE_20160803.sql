USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_dashboard_contest_withLifetimeRCE]    Script Date: 08/02/2016 17:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.08.02
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_dashboard_contest_withLifetimeRCE]
@contest_id	int
AS
DECLARE
@date_begin	date,
@date_end	date
BEGIN

	SET NOCOUNT ON;
	
	select	@date_begin = date_begin,
			@date_end = date_end
	from	contest
	where	contest_id = @contest_id
	
	select	login_id,
			sister_id = login_id
	into	#login_ids
	from	[login]
	where	account_type = 'U'
	union
	select	a.login_id,
			b.sister_id
	from	[login] a,
			login_pie b
	where	a.login_id = b.login_id and
			a.account_type = 'G'
	
	select	*
	into	#temp1
	from	(
				select	a.enroll_site_id,
						login_id = isnull(c1.contest_login_id, c.sister_id),
						est_rce = isnull(b.total_est_rce, 0),
						actual_rce = isnull(b.total_rce, 0)
				from	enroll_customer_site a,
						--enroll_customer a1,
						enroll_customer_site_contest_history b,
						#login_ids c,
						[login] c1
				where	a.enroll_site_id = b.enroll_site_id and
						a.agent_id = c.login_id and
						c.sister_id = c1.login_id and
						--a.enroll_customer_id = a1.enroll_customer_id and
						--a.enroll_site_status not in ('C', 'Z') and
						--a1.enroll_customer_status not in ('I', 'X', 'Z') and
						b.carry_yn = 0 and
						b.contest_id = @contest_id and
						(b.total_est_rce is not null or b.total_rce is not null) and
						(@date_begin is null or @date_begin <= b.contest_date) and
						(@date_end is null or b.contest_date <= @date_end)
				union
				select	a.enroll_site_id,
						login_id = isnull(c1.contest_login_id, c.sister_id),
						est_rce = isnull(b.total_est_rce, 0),
						actual_rce = isnull(b.total_rce, 0)
				from	enroll_customer_site a,
						--enroll_customer a1,
						enroll_customer_site_contest_history b,
						#login_ids c,
						[login] c1
				where	a.enroll_site_id = b.enroll_site_id and
						a.manager_id = c.login_id and
						c.sister_id = c1.login_id and
						c1.[login_type] = 'T' and
						--a.enroll_customer_id = a1.enroll_customer_id and
						--a.enroll_site_status not in ('C', 'Z') and
						--a1.enroll_customer_status not in ('I', 'X', 'Z') and
						b.carry_yn = 0 and
						b.contest_id = @contest_id and
						(b.total_est_rce is not null or b.total_rce is not null) and
						(@date_begin is null or @date_begin <= b.contest_date) and
						(@date_end is null or b.contest_date <= @date_end)
			) a
			
	select	*
	into	#temp2
	from	(
				select	a.enroll_site_id,
						login_id = isnull(c1.contest_login_id, c.sister_id),
						est_rce = isnull(b.total_est_rce, 0),
						actual_rce = isnull(b.total_rce, 0)
				from	enroll_customer_site a,
						--enroll_customer a1,
						enroll_customer_site_contest_history b,
						#login_ids c,
						[login] c1
				where	a.enroll_site_id = b.enroll_site_id and
						a.agent_id = c.login_id and
						c.sister_id = c1.login_id and
						--a.enroll_customer_id = a1.enroll_customer_id and
						--a.enroll_site_status not in ('C', 'Z') and
						--a1.enroll_customer_status not in ('I', 'X', 'Z') and
						b.carry_yn = 1 and
						b.contest_id = @contest_id and
						(b.total_est_rce is not null or b.total_rce is not null) and
						(@date_begin is null or @date_begin <= b.contest_date) and
						(@date_end is null or b.contest_date <= @date_end)
				union
				select	a.enroll_site_id,
						login_id = isnull(c1.contest_login_id, c.sister_id),
						est_rce = isnull(b.total_est_rce, 0),
						actual_rce = isnull(b.total_rce, 0)
				from	enroll_customer_site a,
						--enroll_customer a1,
						enroll_customer_site_contest_history b,
						#login_ids c,
						[login] c1
				where	a.enroll_site_id = b.enroll_site_id and
						a.manager_id = c.login_id and
						c.sister_id = c1.login_id and
						c1.[login_type] = 'T' and
						--a.enroll_customer_id = a1.enroll_customer_id and
						--a.enroll_site_status not in ('C', 'Z') and
						--a1.enroll_customer_status not in ('I', 'X', 'Z') and
						b.carry_yn = 1 and
						b.contest_id = @contest_id and
						(b.total_est_rce is not null or b.total_rce is not null) and
						(@date_begin is null or @date_begin <= b.contest_date) and
						(@date_end is null or b.contest_date <= @date_end)
			) a			
	
		select	a.login_id,
				--a.full_name,
				full_name = a.short_name,
				a.photo_name,
				est_rce = b.est_rce,
				actual_rce = b.actual_rce,
				co_est_rce = c.est_rce,
				co_actual_rce = c.actual_rce,
				total_est_rce = isnull(b.est_rce, 0.00) + isnull(c.est_rce, 0.00),
				total_actual_rce = isnull(b.actual_rce, 0.00) + isnull(c.actual_rce, 0.00),
				lifetime_actual_rce = dbo.fget_lifetime_rce_enrolled(a.login_id)
		from	[login] a
				left outer join
				(	
					select	login_id,
							est_rce = sum(est_rce),
							actual_rce = sum(actual_rce)
					from	#temp1
					where	login_id not in
							(
								select	login_id
								from	contest_login_unsub
								where	contest_id = @contest_id
							)
					group by login_id
				) b on a.login_id = b.login_id
				left outer join
				(	
					select	login_id,
							est_rce = sum(est_rce),
							actual_rce = sum(actual_rce)
					from	#temp2
					where	login_id not in
							(
								select	login_id
								from	contest_login_unsub
								where	contest_id = @contest_id
							)
					group by login_id
				) c on a.login_id = c.login_id
		where	a.login_status = 'A' and
				a.[login_type] in ('S', 'T') and
				(b.login_id is not null or c.login_id is not null)

END


