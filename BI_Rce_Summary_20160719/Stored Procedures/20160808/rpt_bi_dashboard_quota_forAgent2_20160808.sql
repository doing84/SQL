USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_quota_forAgent]    Script Date: 08/08/2016 18:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.05
-- Description:	Modifying
-- =============================================
CREATE PROCEDURE [dbo].[rpt_bi_dashboard_quota_forAgent2]
@date_begin		date = null, 
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;

	select	*
	into	#active_agents
	from	(
				select	group_id = a.login_id,
						a.login_id,
						a.member_id,
						member_type = 'M',
						account_type = 'G'
				from	login_member a,
						[login] b,
						[login] c
				where	a.login_id = b.login_id and
						a.member_id = c.login_id and
						b.[login_type] = 'S' and
						b.login_status = 'A' and
						c.[login_type] = 'S' and
						c.login_status = 'A'						
			) a
	
	select	login_id = a.login_id,
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
	into	#bi_dashboard_rce_forAgent		
	from	(
				select	total_rce_e = sum(isnull(a.total_est_rce, 0)),
						total_rce_a = sum(isnull(a.total_rce, 0)),
						b.login_id
				from	enroll_customer_site a,
						enroll_customer a0,
						enroll_customer_site_contract a1,
						#active_agents b
				where	a.enroll_customer_id = a0.enroll_customer_id and
						a.enroll_site_id = a1.enroll_site_id and
						a.enroll_site_status <> 'C' and
						a0.enroll_customer_status <> 'Z' and
						a.agent_id = b.login_id and
						(@date_begin is null or @date_begin <= a1.sign_date) and
						(@date_end is null or a1.sign_date <= @date_end)
				group by b.login_id
			) a 
			left outer join
			(
				select	total_rce_deleted_e = sum(isnull(a.total_est_rce, 0)),
						total_rce_deleted_a = sum(isnull(a.total_rce, 0)),
						b.login_id
				from	enroll_customer_site  a,
						enroll_customer a0,
						enroll_customer_site_contract a1,
						#active_agents b
				where	a.enroll_customer_id = a0.enroll_customer_id and
						a.enroll_site_id = a1.enroll_site_id and
						a.enroll_site_status = 'C' and
						a.agent_id = b.login_id and
						(@date_begin is null or @date_begin <= a1.sign_date) and
						(@date_end is null or a1.sign_date <= @date_end)
				group by b.login_id
			) a1 on a.login_id = a1.login_id
			left outer join
			(
				select	total_rce_inactive_e = sum(isnull(a.total_est_rce, 0)),
						total_rce_inactive_a = sum(isnull(a.total_rce, 0)),
						b.login_id
				from	enroll_customer_site a,
						enroll_customer a0,
						enroll_customer_site_contract a1,
						#active_agents b
				where	a.enroll_customer_id = a0.enroll_customer_id and
						a.enroll_site_id = a1.enroll_site_id and
						a0.enroll_customer_status = 'I' and
						a.enroll_site_status = 'I' and
						a.agent_id = b.login_id and
						(@date_begin is null or @date_begin <= a1.sign_date) and
						(@date_end is null or a1.sign_date <= @date_end)
				group by b.login_id
			) a2 on a.login_id = a2.login_id
			left outer join
			(
				select	total_rce_enrolled_e = sum(isnull(a.total_est_rce, 0)),
						total_rce_enrolled_a = sum(isnull(a.total_rce, 0)),
						b.login_id
				from	enroll_customer_site a,
						enroll_customer a0,
						enroll_customer_site_contract a1,
						#active_agents b
				where	a.enroll_customer_id = a0.enroll_customer_id and
						a.enroll_site_id = a1.enroll_site_id and
						a0.enroll_customer_status in ('X', 'I', 'U', 'C', 'D', 'Z') and
						a.enroll_site_status in ('G', 'X', 'Y') and
						a.agent_id = b.login_id and
						(@date_begin is null or @date_begin <= a1.sign_date) and
						(@date_end is null or a1.sign_date <= @date_end)
				group by b.login_id
			) a3 on a.login_id = a3.login_id
			left outer join
			(
				select	total_rce_cancelled_e = sum(isnull(a.total_est_rce, 0)),
						total_rce_cancelled_a = sum(isnull(a.total_rce, 0)),
						b.login_id
				from	enroll_customer_site a,
						enroll_customer a0,
						enroll_customer_site_contract a1,
						#active_agents b
				where	a.enroll_customer_id = a0.enroll_customer_id and
						a.enroll_site_id = a1.enroll_site_id and
						a0.enroll_customer_status in ('X', 'I', 'U', 'C', 'D', 'Z') and
						a.enroll_site_status = 'Z' and
						a.agent_id = b.login_id and
						(@date_begin is null or @date_begin <= a1.sign_date) and
						(@date_end is null or a1.sign_date <= @date_end)
				group by b.login_id
			) a4 on a.login_id = a4.login_id


		select	top 4 rce_rate = b.total_rce_a / nullif(b.quota_rce, 0.00),
				b.quota_rce,
				b.total_rce_a, 
				b.total_processed_a,
				b.total_rce_a,
				b.total_rce_enrolled_a,
				net_rce_e = b.total_processed_e - b.total_rce_cancelled_e,
				net_rce_a = b.total_processed_a - b.total_rce_cancelled_a,
				name = c.short_name
		from	(
					select	a.*,
							quota_rce = isnull(b.quota_week, 0.00),
							total_processed_e = a.total_rce_e - (a.total_rce_inactive_e + a.total_rce_deleted_e),
							total_processed_a = a.total_rce_a - (a.total_rce_inactive_a + a.total_rce_deleted_a)
					from	#bi_dashboard_rce_forAgent a, [login] b
					where	a.login_id = b.login_id
						
				) b,
		[login] c
		where b.login_id = c.login_id
		order by rce_rate desc
END
		