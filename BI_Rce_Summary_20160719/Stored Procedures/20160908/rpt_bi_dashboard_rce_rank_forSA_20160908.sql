USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_rce_rank_forSA]    Script Date: 09/08/2016 20:18:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.08
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_rce_rank_forSA]
@date_begin	date = null,
@date_end	date = null
AS
BEGIN

	SET NOCOUNT ON;
			
	select	a.*
	from	(			
				select	login_id,
						login_name = short_name,
						est_rce = dbo.fget_bi_total_est_rce(login_id, @date_begin, @date_end),
						act_rce = dbo.fget_bi_total_act_rce(login_id, @date_begin, @date_end)
				from	[login]
				where	[login_type] = 'S' and
						login_status = 'A' and
						duty_yn = 1
			) a
	order by act_rce desc, est_rce desc

END

