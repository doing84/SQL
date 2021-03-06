USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_quota_rank_forEA]    Script Date: 09/08/2016 20:17:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.08
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_quota_rank_forEA]
@date_begin	date = null,
@date_end	date = null
AS
BEGIN

	SET NOCOUNT ON;
			
	select	a.*,
			rce_rate = convert(float, est_rce) / nullif(quota_rce, 0)
	from	(			
				select	login_id,
						login_name = short_name,
						quota_rce = (isnull(quota_day, 0)) * (convert(int, datediff(day, @date_begin, @date_end))+ 1),
						est_rce = dbo.fget_bi_total_est_rce(login_id, @date_begin, @date_end),
						act_rce = dbo.fget_bi_total_act_rce(login_id, @date_begin, @date_end)
				from	[login]
				where	[login_type] = 'S' and
						login_status = 'A' and
						emp_type = 'E' and
						duty_yn = 1
			) a
	order by rce_rate desc, est_rce desc

END

