USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_trend_week]    Script Date: 08/05/2016 15:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.04
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_trend_week]
@year_id1	int,
@year_id2	int
AS
BEGIN

	SET NOCOUNT ON;

	
select	a.*,
		b.year2_total_rce_a
from	(
			select	week_id,
					year1_total_rce_a = isnull(total_rce_a, 0.00)
			from	bi_dashboard_week_summary
			where	year_id = @year_id1
		) a,
		(
			select	week_id,
					year2_total_rce_a = isnull(total_rce_a, 0.00)
			from	bi_dashboard_week_summary
			where	year_id = @year_id2
		) b
where	a.week_id = b.week_id
	
END

