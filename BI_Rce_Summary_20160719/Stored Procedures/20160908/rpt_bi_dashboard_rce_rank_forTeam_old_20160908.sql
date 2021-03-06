USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_rce_rank_forTeam]    Script Date: 09/08/2016 16:27:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.08
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_rce_rank_forTeam_old] 
@date_begin		date = null, 
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;

/*
	select	distinct
			a.login_id
	into	#login_ids
	from	login_member a,
			[login] b
	where	a.login_id = b.login_id and
			b.[login_type] = 'S' and
			b.login_status = 'A'
*/	
	
	select	*
	into	#login_ids
	from	(
				select	group_id = a.login_id,
						a.login_id,
						member_id = a.login_id
				from	(			
							select	distinct
									a.login_id
							from	login_member a,
									[login] b
							where	a.login_id = b.login_id and
									b.[login_type] = 'S' and
									b.login_status = 'A'
						) a
				union
				select	group_id = a.login_id,
						a.login_id,
						a.member_id
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
			
	select	total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0)),
			b.group_id
	into	#total_gross
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1,
			#login_ids b
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_contract_id = a1.enroll_contract_id and
			a.agent_id = b.login_id and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	group by b.group_id

	select	total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0)),
			b.group_id
	into	#total_deleted
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1,
			#login_ids b
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_contract_id = a1.enroll_contract_id and
			a.agent_id = b.login_id and
			a.enroll_site_status = 'C' and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	group by b.group_id
			
	select	total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0)),
			b.group_id
	into	#total_inactive
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1,
			#login_ids b
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_contract_id = a1.enroll_contract_id and
			a.agent_id = b.login_id and
			a0.enroll_customer_status = 'I' and
			a.enroll_site_status = 'I' and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	group by b.group_id
			
	select	total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0)),
			c.group_id
	into	#total_enrolled
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1,
			#login_ids c,
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
			a.agent_id = c.login_id and
			a0.enroll_customer_status in ('X', 'I', 'U', 'C', 'D', 'Z') and
			a.enroll_site_status in ('G', 'X', 'Y') 
	group by c.group_id
	
	select	total_rce_e = sum(isnull(a.total_est_rce, 0)),
			total_rce_a = sum(isnull(a.total_rce, 0)),
			c.group_id
	into	#total_cancelled
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1,
			#login_ids c,
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
			a.agent_id = c.login_id and
			a0.enroll_customer_status in ('X', 'I', 'U', 'C', 'D', 'Z') and
			a.enroll_site_status = 'Z' 
	group by c.group_id
	
	select	total_processed_a = total_rce_a - (total_rce_inactive_a + total_rce_deleted_a), 
			total_processed_e = total_rce_e - (total_rce_inactive_e + total_rce_deleted_e),
			total_rce_a,
			total_rce_e,
			total_rce_enrolled_a,
			total_rce_enrolled_e,
			name = c.short_name
			
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
							select	group_id,
									net_rce_e = sum(a.total_rce_e),
									net_rce_a = sum(a.total_rce_a)
							from	(
										select	rce_type = 'G',
												group_id,
												total_rce_e,
												total_rce_a
										from	#total_gross
										union
										select	rce_type = 'D',
												group_id,
												-total_rce_e,
												-total_rce_a
										from	#total_deleted
										union
										select	rce_type = 'I',
												group_id,
												-total_rce_e,
												-total_rce_a
										from	#total_inactive
										union
										select	rce_type = 'E',
												group_id,
												-total_rce_e,
												-total_rce_a
										from	#total_enrolled
										union
										select	rce_type = 'C',
												group_id,
												-total_rce_e,
												-total_rce_a
										from	#total_cancelled
									) a
							group by group_id
						) a
			left outer join #total_gross b on a.group_id = b.group_id
			left outer join #total_deleted c on a.group_id = c.group_id
			left outer join #total_inactive d on a.group_id = d.group_id
			left outer join #total_enrolled e on a.group_id = e.group_id
			left outer join #total_cancelled f on a.group_id = f.group_id
			) a,	
	[login] c		
	where	a.group_id = c.login_id 
			
END

/*
select	a.*,
						rce_rate = a.total_rce / nullif(a.quota_rce, 0),
						
						b.group_total_rce,
						b.group_quota_rce,
						group_rce_rate = b.group_total_rce / nullif(b.group_quota_rce, 0)
				from	#active_agents_summary a,
						(
							select	group_id,
									group_total_rce = sum(total_rce),
									group_quota_rce = sum(quota_rce)
							from	#active_agents_summary
							group by group_id
						) b
				where	a.group_id = b.group_id
*/
