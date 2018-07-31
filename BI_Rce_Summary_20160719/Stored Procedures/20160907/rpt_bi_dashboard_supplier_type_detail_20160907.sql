USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_bi_dashboard_supplier_type_detail]    Script Date: 09/07/2016 18:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.08
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_bi_dashboard_supplier_type_detail]
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
		--		(isnull(c1.total_count,0) / convert(float, a.total_count)),
				
		sv_gas = isnull(b.total_count,0),
		sv_elec = isnull(b1.total_count,0),
		
		lv_gas = isnull(c.total_count,0),
		lv_elec = isnull(c1.total_count,0)
into	#rpt_bi_service_type
from	(			
			select	sign_date,
					total_count = count(b.enroll_contract_id)
			from	enroll_customer_site a,
					enroll_customer_site_contract b
			where	a.enroll_contract_id = b.enroll_contract_id and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) a
		left outer join
		(	--sv_gas
			select	sign_date,
					total_count = count(b.enroll_contract_id)
			from	enroll_customer_site a,
					enroll_customer_site_contract b
			where	a.enroll_contract_id = b.enroll_contract_id and
					a.service_type = 'S' and
					a.supplier_type = 'G' and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) b on a.sign_date = b.sign_date
		left outer join
		(	--sv_elect
			select	sign_date,
					total_count = count(b.enroll_contract_id)
			from	enroll_customer_site a,
					enroll_customer_site_contract b
			where	a.enroll_contract_id = b.enroll_contract_id and
					a.service_type = 'S' and
					a.supplier_type = 'E' and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) b1 on a.sign_date = b1.sign_date
		left outer join
		(	--lv_gas
			select	sign_date,
					total_count = count(b.enroll_contract_id)
			from	enroll_customer_site a,
					enroll_customer_site_contract b
			where	a.enroll_contract_id = b.enroll_contract_id and
					service_type = 'L' and
					supplier_type = 'G' and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) c	on a.sign_date = c.sign_date
		left outer join
		(	--lv_elec
			select	sign_date,
					total_count = count(b.enroll_contract_id)
			from	enroll_customer_site a,
					enroll_customer_site_contract b
			where	a.enroll_contract_id = b.enroll_contract_id and
					service_type = 'L' and
					supplier_type = 'E' and
					(@date_begin is null or @date_begin <= sign_date) and
					(@date_end is null or sign_date <= @date_end)
			group by sign_date
		) c1 on a.sign_date = c1.sign_date

select	sv_gas = sum(sv_gas),
		sv_elec = sum(sv_elec),
		lv_gas = sum(lv_gas),
		lv_elec = sum(lv_elec)
from	#rpt_bi_service_type
where	sign_date between @date_begin and @date_end

END

