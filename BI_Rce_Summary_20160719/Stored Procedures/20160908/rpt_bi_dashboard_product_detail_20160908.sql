USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_product_detail]    Script Date: 09/09/2016 08:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.08
-- Description:	
-- Author:		CHOI
-- Update date: 2016.09.09
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_product_detail]
@date_begin		date = null,
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;

	select	a.sign_date,
			a.total_count,
			--total = (isnull(b.total_count,0) / convert(float, a.total_count)) +
			--		(isnull(b1.total_count,0) / convert(float, a.total_count)) + 
			--		(isnull(c.total_count,0) / convert(float, a.total_count)) +
			--		(isnull(c1.total_count,0) / convert(float, a.total_count)) +
			--		(isnull(d.total_count,0) / convert(float, a.total_count)) +
			--		(isnull(d1.total_count,0) / convert(float, a.total_count)),
					
			hoep_gas = isnull(b.total_count, 0),
			hoep_elec = isnull(b1.total_count, 0),
			
			intro_gas = isnull(c.total_count, 0),
			intro_elec = isnull(c1.total_count, 0),
			
			fixed_gas = isnull(d.total_count, 0),
			fixed_elec = isnull(d1.total_count, 0)
			
	into	#rpt_bi_product_detail
	from	(			
				select	b.sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by b.sign_date
			) a
			left outer join
			(	--hoep_gas
				select	b.sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.supplier_type = 'G' and
						b.item_type = 'H' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by b.sign_date
			) b on a.sign_date = b.sign_date
			left outer join
			(	--hoep_elec
				select	b.sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.supplier_type = 'E' and
						b.item_type = 'H' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by b.sign_date
			) b1 on a.sign_date = b1.sign_date
			left outer join
			(	--intro_gas
				select	b.sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.supplier_type = 'G' and
						b.item_type = 'I' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by b.sign_date
			) c on a.sign_date = c.sign_date
			left outer join
			(	--intro_elec
				select	b.sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.supplier_type = 'E' and
						b.item_type = 'I' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by b.sign_date
			) c1 on a.sign_date = c1.sign_date
			left outer join
			(	--fixed_gas
				select	b.sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.supplier_type = 'G' and
						b.item_type = 'F' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by b.sign_date
			) d on a.sign_date = d.sign_date
			left outer join
			(	--fixed_elec
				select	b.sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.supplier_type = 'E' and
						b.item_type = 'F' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by b.sign_date
			) d1 on a.sign_date = d1.sign_date

	select	hoep_gas = sum(hoep_gas),
			hoep_elec = sum(hoep_elec),
			intro_gas = sum(intro_gas),
			intro_elec = sum(intro_elec),
			fixed_gas = sum(fixed_gas),
			fixed_elec = sum(fixed_elec)
	from	#rpt_bi_product_detail
	
END

