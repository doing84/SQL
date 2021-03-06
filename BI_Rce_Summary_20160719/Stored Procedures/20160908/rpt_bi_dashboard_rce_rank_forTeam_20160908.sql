USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_rce_rank_forTeam]    Script Date: 09/08/2016 20:18:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.08
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_rce_rank_forTeam]
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
									b.login_status = 'A' and
									b.duty_yn = 1
						) a
				union
				-- Group Member
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
						b.duty_yn = 1 and
						c.[login_type] = 'S' and
						c.login_status = 'A' and
						c.duty_yn = 1 
			) a
			
	select	a.*,
			login_name = b.short_name
	from	(			
				select	group_id,
						est_rce = sum(dbo.fget_bi_total_est_rce(member_id, @date_begin, @date_end)),
						act_rce = sum(dbo.fget_bi_total_act_rce(member_id, @date_begin, @date_end))
				from	#login_ids a
				group by group_id
			) a
	left outer join [login] b on a.group_id = b.login_id
	order by act_rce desc, est_rce desc

END

