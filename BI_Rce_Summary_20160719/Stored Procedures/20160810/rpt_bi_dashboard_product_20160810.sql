USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_product]    Script Date: 08/10/2016 10:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.08
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[rpt_bi_dashboard_product]
@date_begin		date = null,
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;

select	a.sign_date,
		total = (isnull(b.total_count,0) / convert(float, a.total_count)) * 100 + 
				(isnull(c.total_count,0) / convert(float, a.total_count)) * 100 +
				(isnull(d.total_count,0) / convert(float, a.total_count)) * 100,
				
		hoep = (isnull(b.total_count,0) / convert(float, a.total_count)) * 100.00,
		fixed = (isnull(c.total_count,0) / convert(float, a.total_count)) * 100.00,
		intro = (isnull(d.total_count,0) / convert(float, a.total_count)) * 100.00
into	#rpt_bi_product
from	(			
			select	sign_date,
					total_count = count(enroll_contract_id)
			from	enroll_customer_site_contract
			where	(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) a
		left outer join
		(	
			select	sign_date,
					total_count = count(enroll_contract_id)
			from	enroll_customer_site_contract
			where	item_type = 'F' and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) b on a.sign_date = b.sign_date
		left outer join
		(	
			select	sign_date,
					total_count = count(enroll_contract_id)
			from	enroll_customer_site_contract
			where	item_type = 'I' and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) c on a.sign_date = c.sign_date
		left outer join
		(	
			select	sign_date,
					total_count = count(enroll_contract_id)
			from	enroll_customer_site_contract
			where	item_type = 'H' and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) d on a.sign_date = d.sign_date

select	hoep = isnull(sum(hoep), 0) / convert(float, sum(total)) * 100,
		fixed  = isnull(sum(fixed), 0) / convert(float, sum(total)) * 100,
		intro  = isnull(sum(intro), 0) / convert(float, sum(total)) * 100
from	#rpt_bi_product
	
END

