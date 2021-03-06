USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_supplier_type]    Script Date: 09/07/2016 18:51:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.09
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_supplier_type]
@date_begin		date = null,
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;

select	a.sign_date,
		--total = (isnull(b.total_count,0) / convert(float, a.total_count)) + 
		--		(isnull(c.total_count,0) / convert(float, a.total_count)),
		gas = isnull(b.total_count,0),
		electric = isnull(c.total_count,0)
into	#rpt_bi_supplier_type
from	(			
			select	sign_date,
					total_count = count(b.enroll_contract_id)
			from	enroll_customer_site a,
					enroll_customer_site_contract b
			where	a.enroll_contract_id = b.enroll_contract_id and
					(@date_begin is null or @date_begin <= b.sign_date) and
					(@date_end is null or b.sign_date <= @date_end)
			group by sign_date
		) a
		left outer join
		(	
			select	sign_date,
					total_count = count(b.enroll_contract_id)
			from	enroll_customer_site a,
					enroll_customer_site_contract b
			where	a.enroll_contract_id = b.enroll_contract_id and
					a.supplier_type = 'G' and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) b on a.sign_date = b.sign_date
		left outer join
		(	
			select	sign_date,
					total_count = count(b.enroll_contract_id)
			from	enroll_customer_site a,
					enroll_customer_site_contract b
			where	a.enroll_contract_id = b.enroll_contract_id and
					a.supplier_type = 'E' and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) c	on a.sign_date = c.sign_date
		
select	gas = sum(gas),
		electric = sum(electric)
from	#rpt_bi_supplier_type
where	sign_date between @date_begin and @date_end
		
END

