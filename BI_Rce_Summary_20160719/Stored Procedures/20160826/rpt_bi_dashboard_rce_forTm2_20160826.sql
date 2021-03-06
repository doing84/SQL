USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_rce_forTm2]    Script Date: 08/26/2016 19:51:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.23
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_rce_forTm2]
@date_begin		date = null,
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;
	
	
	select	a.register_id,
			a.total_appt,
			b.total_close,
			close_rate = (isnull(b.total_close,0) / convert(float, a.total_appt)) * 100
	into	#rpt_bi_rce_forTm
	from	(
				select	a.register_id,
						total_appt = isnull(count(b.detail_id), 0)
				from	crm_call a,
						crm_call_detail b,
						[login] c
				where	a.call_id = b.call_id and
						b.register_id = c.login_id and
						a.call_category_id in
						(
							14,
							23
						) and
						c.login_status = 'A' and
						c.[login_type] = 'T' and
						b.detail_date2 between @date_begin and @date_end 						
				group by a.register_id
			) a
			left outer join
			(
				select	a.register_id,
						total_close = isnull(count(b.detail_id), 0)
				from	crm_call a,
						crm_call_detail b,
						enroll_customer c,
						[login] d
				where	a.call_id = b.call_id and
						b.register_id = d.login_id and
						b.detail_id = c.crm_call_detail_id and
						a.call_category_id in
						(
							14,
							23
						) and
						d.login_status = 'A' and
						d.[login_type] = 'T' and
						b.detail_date2 between @date_begin and @date_end
				group by a.register_id
			) b on a.register_id = b.register_id
			
		
	select	top 3 
			total_rce_a = dbo.fget_agent_production_act_rce_summary(login_id, @date_begin, @date_end),
			c.close_rate, 
	        c.total_close,
	        a.register_id,
			name = b.short_name 
	from	#rpt_bi_rce_forTm a
			left outer join [login] b on a.register_id = b.login_id
			inner join 
			(
				select	close_rate = isnull(sum(total_close), 0) / convert(float, sum(total_appt)) * 100,
						total_close = isnull(sum(total_close), 0),
						register_id
				from	#rpt_bi_rce_forTm
				group by register_id 
			) c on a.register_id = c.register_id
	order by total_rce_a desc
		
END
