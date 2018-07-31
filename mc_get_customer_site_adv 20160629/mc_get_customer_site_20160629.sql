USE [CEW]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:        SKC
-- Create date: 2016.06.29
-- Description:   
-- =============================================
CREATE PROCEDURE mc_get_enroll_customer_site_adv
@enroll_site_id   int
AS
BEGIN

      SET NOCOUNT ON;
      
      select      b.contract_type,
                  b.enroll_commission_type,
                  b.intro_price_id,
                  b.intro_id,
                  b.intro_rate,
                  b.intro_price,
                  b.intro_month,
                  b.mature_rate,
                  b.mature_price,
                  b.mature_month,
                  b.pool_id,
                  b.price_id,
                  b.selling_price,
                  b.price_type,
                  b.add_price,
                  b.admin_fee,
                  b.term_month,
                  b.term_year,
                  b.[start_date],
                  b.end_date,
                  b.sign_date,
                  contract_type_desc = b1.type_desc,
                  price_type_desc = b2.type_desc,
                  supplier_type_desc = a1.type_desc,
                  service_type_desc = a2.type_desc,
                  a.*
      from  enroll_customer_site a
                  inner join supplier_type a1 on a.supplier_type = a1.type_code
                  inner join enroll_service_type a2 on a.service_type = a2.type_code
                  
                  inner join enroll_customer_site_contract b on a.enroll_contract_id = b.enroll_contract_id
                  inner join enroll_contract_type b1 on b.contract_type = b1.type_code
                  left outer join price_type b2 on b.price_type = b2.type_code
      where a.enroll_site_status <> 'C' and
                  a.enroll_site_id = @enroll_site_id
      
END







