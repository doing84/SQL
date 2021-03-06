USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[mc_get_cancel_customer_site]    Script Date: 06/29/2016 07:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.28
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[mc_get_cancel_customer_site]
@enroll_site_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	--a.unit_no,
			site_address = a.address1, 
			--a.address2,
			--a.city,
			--a.province_id,
			--a.country_id,
			a.postal_code,
			a.account_number,
			a.est_usage,
			service_type = a.service_type,
			service_desc = a1.type_desc,
			
									
			b.intro_price,
			b.intro_month,
			b.mature_price,
			b.mature_month,
			kwh = b.selling_price,
			b.price_type,
			program_fee = b.add_price,
			b.term_year,
			b.[start_date],
			b.sign_date,
			contract_type = b1.type_code,
			price_type_desc = b2.type_desc,
			
			
			c.supplier_type,
			c.supplier_desc
			
	from	enroll_customer_site a
			left outer join enroll_service_type a1 on a.service_type = a1.type_code
			inner join enroll_customer_site_contract b on a.enroll_contract_id = b.enroll_contract_id
			left outer join enroll_contract_type b1 on b.contract_type = b1.type_code 
			left outer join price_type b2 on b.price_type = b2.type_code
			inner join supplier c on a.supplier_id = c.supplier_id 	
			
						
	where	a.enroll_site_status <> 'C' and
			a.enroll_site_id = @enroll_site_id
	
END


