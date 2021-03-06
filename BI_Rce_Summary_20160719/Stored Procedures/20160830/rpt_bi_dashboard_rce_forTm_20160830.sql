USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_rce_forTm2]    Script Date: 08/30/2016 13:26:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.23
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_rce_forTm] '2016-03-01', '2016-06-30'
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
						(@date_begin is null or @date_begin <= b.detail_date2) and
						(@date_end is null or b.detail_date2 <= @date_end) 						
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
						(@date_begin is null or @date_begin <= b.detail_date2) and
						(@date_end is null or b.detail_date2 <= @date_end)
				group by a.register_id
			) b on a.register_id = b.register_id
			
	select	top 3 
			total_rce_a = isnull(dbo.fget_bi_dashboard_rce(login_id, @date_begin, @date_end), 0),
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

