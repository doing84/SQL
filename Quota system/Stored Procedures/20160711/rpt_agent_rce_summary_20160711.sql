USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_agent_rce_summary]    Script Date: 07/11/2016 10:33:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.07.08
-- Description:	
-- =============================================
/*
update	login
set		quota_week = 50

update	login
set		quota_week = null
*/
ALTER PROCEDURE [dbo].[rpt_agent_rce_summary]
@login_id	int,
@date_begin	date,
@date_end	date,
@agent_id	int = null,
@agent_type	char(1) = null,
@emp_type	char(1) = null
AS
BEGIN

	SET NOCOUNT ON;
	
	/*
	select	a.*
	into	#login_ids
	from	(
				select	login_id = @login_id
				union
				select	a.member_id
				from	login_member a,
						[login] b
				where	a.member_id = b.login_id and
						b.login_status = 'A' and
						a.login_id = @login_id
			) a
	where	(@agent_id is null or login_id = @agent_id)
	*/
	
	select	login_id
	into	#login_ids
	from	[login]
	where	login_status = 'A' and
			(@agent_id is null or login_id = @agent_id) and
			(@agent_type is null or [login_type] = @agent_type) and
			(@emp_type is null or emp_type = @emp_type)
	
	/*
	14	Appointment
	23	Rebooked
	*/
	
	select	*,
	
			--total_appt = isnull(dbo.fget_agent_production_appt_summary(login_id, @date_begin, @date_end), 0),
			--total_closed = isnull(dbo.fget_agent_production_closed_summary(login_id, @date_begin, @date_end), 0),
			--total_closed_forSP = isnull(dbo.fget_agent_production_closed_summary_forSP(login_id, @date_begin, @date_end), 0),
			
			total_crm_rce = dbo.fget_agent_production_crm_rce_summary(login_id, @date_begin, @date_end),
			total_est_rce = dbo.fget_agent_production_est_rce_summary(login_id, @date_begin, @date_end),
			total_act_rce = dbo.fget_agent_production_act_rce_summary(login_id, @date_begin, @date_end),
			total_est_rce_forSP = dbo.fget_agent_production_est_rce_summary_forSP(login_id, @date_begin, @date_end)
			
	into	#rpt_agent_rce_summary
	from	#login_ids
	
	declare @total_days int = datediff(day, @date_begin, @date_end) + 1
	
	select	a.*,
			
			total_crm_rce_rate = total_crm_rce / total_quota_rce,
			total_est_rce_rate = total_est_rce / total_quota_rce,
			total_act_rce_rate = total_act_rce / total_quota_rce,
			total_est_rce_rate_forSP = total_est_rce_forSP / total_quota_rce
			
	from	(
				select	a.*,
				
						--total_closed_rate = convert(float, total_closed) / nullif(total_appt, 0),
						--total_closed_rate_forSP = convert(float, total_closed + total_closed_forSP) / nullif(total_appt + total_closed_forSP, 0),
						
						total_quota_rce = convert(numeric(9, 2), nullif(@total_days * b.quota_day, 0)),
						
						b.full_name,
						b.photo_name
				from	#rpt_agent_rce_summary a
						inner join [login] b on a.login_id = b.login_id
				where	--total_appt > 0 or
						--total_closed > 0 or
						--total_closed_forSP > 0 or
						total_crm_rce > 0 or
						total_est_rce > 0 or
						total_act_rce > 0 or
						total_est_rce_forSP > 0
			) a
			
END
