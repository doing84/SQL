USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_rce_rank_forSA]    Script Date: 09/08/2016 15:40:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.07
-- Description:	
-- Author:		CHOI
-- Update date: 2016.09.08
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_rce_rank_forSA_old]
@date_begin		date = null, 
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;
	
	select	login_id
	into	#login_ids
	from	[login]
	where	[login_type] = 'S' and
			login_status = 'A' and
			duty_yn = 1 
	--submit				
	select	total_rce_e = sum(isnull(a.total_est_rce, 0)),
			b.login_id
	into	#total_submit
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1,
			#login_ids b
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_contract_id = a1.enroll_contract_id and
			a.enroll_site_status not in ('C', 'Z') and
			a0.enroll_customer_status not in ('I', 'X', 'Z') and
			(a.agent_id = b.login_id or
			 a.manager_id = b.login_id) and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	group by b.login_id
	--enrolled
	select	total_rce_enrolled_a = sum(isnull(a.total_rce, 0)),
			b.login_id
	into	#total_enrolled
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1,
			#login_ids b
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_contract_id = a1.enroll_contract_id and
			a.enroll_site_status = 'G' and
			a0.enroll_customer_status not in ('I', 'X', 'Z') and
			(a.agent_id = b.login_id or
			 a.manager_id = b.login_id) and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	group by b.login_id
	
	select	total_rce_e,
			total_rce_enrolled_a,
			name = c.short_name
	from	(
				select	a.login_id,
						total_rce_e = isnull(a.total_rce_e, 0),
						total_rce_enrolled_a = isnull(b.total_rce_enrolled_a, 0)
				from	#total_submit a
						left outer join #total_enrolled b on a.login_id = b.login_id
			) a,
	[login] c
	where a.login_id = c.login_id
			
END

