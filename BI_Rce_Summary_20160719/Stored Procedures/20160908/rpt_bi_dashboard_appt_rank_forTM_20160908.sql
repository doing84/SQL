USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_appt_rank_forTM]    Script Date: 09/08/2016 20:16:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.09.06
-- Description:	
-- Author:		CHOI
-- Update date: 2016.09.08
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_appt_rank_forTM]
@date_begin	date = null,
@date_end	date = null
AS
BEGIN

	SET NOCOUNT ON;
			
	select	a.*,
			close_rate = convert(float, total_close) / nullif(total_appt, 0)
	from	(			
				select	login_id,
						login_name = short_name,
						total_appt = dbo.fget_bi_total_appt(login_id, @date_begin, @date_end),
						total_close = dbo.fget_bi_total_closed(login_id, @date_begin, @date_end)
				from	[login]
				where	[login_type] = 'T' and
						login_status = 'A' and
						duty_yn = 1
			) a
	order by close_rate desc

END

