USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_product]    Script Date: 08/08/2016 14:14:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.08
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_product]
@date_begin		date = null,
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;



select	a.sign_date,
		hoep = (isnull(a.product_rate,0) / convert(float, d.total_product_rate)) * 100.00,
		fixed = (isnull(b.product_rate,0) / convert(float, d.total_product_rate)) * 100.00,
		intro = (isnull(c.product_rate,0) / convert(float, d.total_product_rate)) * 100.00
from	(			
			select	sign_date,
					product_rate = count(enroll_contract_id)
			from	enroll_customer_site_contract
			where	item_type = 'H' and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) a,
		(	
			select	sign_date,
					product_rate = count(enroll_contract_id)
			from	enroll_customer_site_contract
			where	item_type = 'F' and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) b,
		(	
			select	sign_date,
					product_rate = count(enroll_contract_id)
			from	enroll_customer_site_contract
			where	item_type = 'I' and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) c,
		(	
			select	sign_date,
					total_product_rate = count(enroll_contract_id)
			from	enroll_customer_site_contract
			where	(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) d
where	a.sign_date = b.sign_date and
		b.sign_date = c.sign_date and
		c.sign_date = d.sign_date
		
END

