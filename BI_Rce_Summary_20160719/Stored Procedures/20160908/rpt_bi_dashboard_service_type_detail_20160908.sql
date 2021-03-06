USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_service_type_detail]    Script Date: 09/09/2016 08:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.07
-- Description:
-- Author:		CHOI
-- Update date: 2016.09.09
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_service_type_detail]
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
			
			hoep_sv = isnull(b.total_count, 0),
			hoep_lv = isnull(b1.total_count, 0),
			
			intro_sv = isnull(c.total_count, 0),
			intro_lv = isnull(c1.total_count, 0),
			
			fixed_sv = isnull(d.total_count, 0),
			fixed_lv = isnull(d1.total_count, 0)
			
	into	#rpt_bi_service_type_detail
	from	(			
				select	b.sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by sign_date
			) a
			left outer join
			(	--hoep_sv
				select	b.sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.service_type in ('S', 'R') and
						b.item_type = 'H' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by sign_date
			) b on a.sign_date = b.sign_date
			left outer join
			(	--hoep_sv
				select	b.sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.service_type = 'L' and
						b.item_type = 'H' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by sign_date
			) b1 on a.sign_date = b1.sign_date
			left outer join
			(	--intro_sv
				select	sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.service_type in ('S', 'R') and
						b.item_type = 'I' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by sign_date
			) c	on a.sign_date = c.sign_date
			left outer join
			(	--intro_lv
				select	sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.service_type = 'L' and
						b.item_type = 'I' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by sign_date
			) c1 on a.sign_date = c1.sign_date
			left outer join
			(	--fixed_sv
				select	sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.service_type in ('S', 'R') and
						b.item_type = 'F' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by sign_date
			) d on a.sign_date = d.sign_date
			left outer join
			(	--fixed_lv
				select	sign_date,
						total_count = count(b.enroll_contract_id)
				from	enroll_customer_site a,
						enroll_customer_site_contract b
				where	a.enroll_contract_id = b.enroll_contract_id and
						a.service_type = 'L' and
						b.item_type = 'F' and
						(@date_begin is null or @date_begin <= b.sign_date) and
						(@date_end is null or b.sign_date <= @date_end)
				group by sign_date
			) d1 on a.sign_date = d1.sign_date

	select	hoep_sv = sum(hoep_sv),
			hoep_lv = sum(hoep_lv),
			intro_sv = sum(intro_sv),
			intro_lv = sum(intro_lv),
			fixed_sv = sum(fixed_sv),
			fixed_lv = sum(fixed_lv)
	from	#rpt_bi_service_type_detail
	where	sign_date between @date_begin and @date_end

END

