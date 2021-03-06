USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_appointment]    Script Date: 08/09/2016 11:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.08
-- Description:	base on 
--				[rpt_agent_production_adv_summary5]
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_appointment]
@date_begin		date = null,
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.total_appt,
			a.detail_date2,
			b.total_close,
			close_rate = (isnull(b.total_close,0) / convert(float, a.total_appt)) * 100
	into	#rpt_bi_appointment
	from	(
				select	b.detail_date2,
						total_appt = count(isnull(b.detail_id, 0))
				from	crm_call a,
						crm_call_detail b
				where	a.call_id = b.call_id and
						a.call_category_id in
						(
							14,
							23
						) and
						b.detail_date2 between @date_begin and @date_end
				group by b.detail_date2
			) a
			left outer join
			(
				select	b.detail_date2,
						total_close = count(isnull(b.detail_id, 0))
				from	crm_call a,
						crm_call_detail b,
						enroll_customer c
				where	a.call_id = b.call_id and
						b.detail_id = c.crm_call_detail_id and
						a.call_category_id in
						(
							14,
							23
						) and
						b.detail_date2 between @date_begin and @date_end
				group by b.detail_date2
			) b on a.detail_date2 = b.detail_date2
		
	select	total_appt = isnull(sum(total_appt), 0),
			total_close = isnull(sum(total_close), 0),
			close_rate = isnull(sum(total_close), 0) / convert(float, sum(total_appt)) * 100 
	from	#rpt_bi_appointment
	where	detail_date2 between @date_begin and @date_end
	
END


