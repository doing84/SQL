USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_quota_rank_forTeam]    Script Date: 09/09/2016 14:57:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.08
-- Description:	
-- Author:		CHOI
-- Update date: 2016.09.09
-- Description:
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_quota_rank_forTeam]
@date_begin	date = null,
@date_end	date = null
AS
BEGIN

	SET NOCOUNT ON;
	
	select	*
	into	#login_ids
	from	(	--Group Leader
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
				--Group Member
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
			
	select	a.*,
			rce_rate = convert(float, est_rce) / nullif(quota_rce, 0),
			login_name = b.short_name
	from	(			
				select	group_id,
						quota_rce = (isnull(sum(b.quota_day), 0)) * (convert(int, datediff(day, @date_begin, @date_end))+ 1),
						est_rce = sum(dbo.fget_bi_total_est_rce(member_id, @date_begin, @date_end)),
						act_rce = sum(dbo.fget_bi_total_act_rce(member_id, @date_begin, @date_end))
				from	#login_ids a,
						[login] b
				where a.member_id = b.login_id
				group by group_id
			) a,
			[login] b
	where	a.group_id = b.login_id and
			b.duty_yn = 1
	order by act_rce desc, est_rce desc

END

