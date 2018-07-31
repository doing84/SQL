USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.06
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_appt_status]
@date_begin	date = null,
@date_end	date = null
AS
DECLARE
@total_appt  int = 0,
@total_close int = 0
BEGIN

	SET NOCOUNT ON;
	
	select	@total_appt = count(isnull(detail_id, 0))
	from	crm_call a,
			crm_call_detail b
	where	a.call_id = b.call_id and
			a.call_category_id in
			(
				14,
				23
			) and
			(@date_begin is null or @date_begin <= b.detail_date2) and
			(@date_end is null or b.detail_date2 <= @date_end)
		
	select	@total_close = count(isnull(detail_id, 0))
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
			(@date_begin is null or @date_begin <= b.detail_date2) and
			(@date_end is null or b.detail_date2 <= @date_end)
			
	select	a.*,
			close_rate = convert(float, total_close) / nullif(total_appt, 0) * 100
	from	(			
				select	total_appt = @total_appt,
						total_close = @total_close
			) a
	
END

