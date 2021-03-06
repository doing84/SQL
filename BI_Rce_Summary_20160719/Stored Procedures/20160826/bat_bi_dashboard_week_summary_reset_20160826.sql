USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[bat_bi_dashboard_week_summary_reset]    Script Date: 08/26/2016 19:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.08.05
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[bat_bi_dashboard_week_summary_reset]
AS
BEGIN

	SET NOCOUNT ON;
	
	update	bi_dashboard_week_summary
	set		total_rce_a = b.total_rce_a,
			update_date = getdate()
	from	bi_dashboard_week_summary a,
			bi_dashboard_year a1,
			(
				select	year_id = datepart(year, b.sign_date),
						week_id = datepart(week, b.sign_date),
						total_rce_a = sum(a.total_rce)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_site_id = b.enroll_site_id and
						a.total_rce is not null
				group by datepart(year, b.sign_date), datepart(week, b.sign_date)
			) b
	where	a.year_id = a1.year_id and
			a1.lock_yn = 0 and
			a.year_id = b.year_id and
			a.week_id = b.week_id

END

