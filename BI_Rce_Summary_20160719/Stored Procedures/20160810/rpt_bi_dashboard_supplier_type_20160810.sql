USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_supplier_type]    Script Date: 08/10/2016 11:36:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.09
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[rpt_bi_dashboard_supplier_type]
@date_begin		date = null,
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;

select	a.sign_date,
		total = (isnull(b.total_count,0) / convert(float, a.total_count)) * 100 + 
				(isnull(c.total_count,0) / convert(float, a.total_count)) * 100,
		gas = (isnull(b.total_count,0) / convert(float, a.total_count)) * 100.00,
		electric = (isnull(c.total_count,0) / convert(float, a.total_count)) * 100.00
into	#rpt_bi_supplier_type
from	(			
			select	sign_date,
					total_count = count(supplier_type)
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
					total_count = count(supplier_type)
			from	enroll_customer_site a,
					enroll_customer_site_contract b
			where	a.enroll_site_id = b.enroll_site_id and
					supplier_type = 'G' and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) b on a.sign_date = b.sign_date
		left outer join
		(	
			select	sign_date,
					total_count = count(supplier_type)
			from	enroll_customer_site a,
					enroll_customer_site_contract b
			where	a.enroll_site_id = b.enroll_site_id and
					supplier_type = 'E' and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) c	on a.sign_date = c.sign_date
		
select	gas = isnull(sum(gas), 0) / convert(float, sum(total)) * 100,
		electric = isnull(sum(electric), 0) / convert(float, sum(total)) * 100
from	#rpt_bi_supplier_type
where	sign_date between @date_begin and @date_end
		
END

