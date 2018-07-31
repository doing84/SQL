USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.09
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_service_type]
@date_begin		date = null,
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;

select	a.sign_date,
		a.total_count,
		total = (isnull(b.total_count,0) / convert(float, a.total_count)) * 100 + 
				(isnull(c.total_count,0) / convert(float, a.total_count)) * 100,
		sv = (isnull(b.total_count,0) / convert(float, a.total_count)) * 100.00,
		lv = (isnull(c.total_count,0) / convert(float, a.total_count)) * 100.00
into	#rpt_bi_service_type
from	(			
			select	sign_date,
					total_count = count(service_type)
			from	enroll_customer_site a,
					enroll_customer_site_contract b
			where	a.enroll_site_id = b.enroll_site_id and
					(@date_begin is null or @date_begin <= b.sign_date) and
					(@date_end is null or b.sign_date <= @date_end)
			group by sign_date
		) a
		left outer join
		(	
			select	sign_date,
					total_count = count(service_type)
			from	enroll_customer_site a,
					enroll_customer_site_contract b
			where	a.enroll_site_id = b.enroll_site_id and
					a.service_type = 'S' and
					(@date_begin is null or @date_begin <= b.sign_date) and
					(@date_end is null or b.sign_date <= @date_end)
			group by sign_date
		) b on a.sign_date = b.sign_date
		left outer join
		(	
			select	sign_date,
					total_count = count(service_type)
			from	enroll_customer_site a,
					enroll_customer_site_contract b
			where	a.enroll_site_id = b.enroll_site_id and
					a.service_type = 'L' and
					(@date_begin is null or @date_begin <= b.sign_date) and
					(@date_end is null or b.sign_date <= @date_end)
			group by sign_date
		) c	on a.sign_date = c.sign_date


select	sv = isnull(sum(sv), 0) / convert(float, sum(total)) * 100,
		lv = isnull(sum(lv), 0) / convert(float, sum(total)) * 100
from	#rpt_bi_service_type
where	sign_date between @date_begin and @date_end

END

