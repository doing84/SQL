USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_csr_unconfirm_deal_list_and_forExc]    Script Date: 08/26/2016 13:05:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.25
-- Description:	

-- Update:		SKC
-- Update date: 2016.08.26
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_csr_unconfirm_deal_list_and_forExc]
@customer_name		varchar(50) = null,
@call_count_begin	int = null,
@call_count_end		int = null,
@date_begin			date = null,
@date_end			date = null,
@deal1_yn			bit,
@deal2_yn			bit,
@deal3_yn			bit,
@deal4_yn			bit,
@deal5_yn			bit,
@deal6_yn			bit
AS
BEGIN

	SET NOCOUNT ON;
	
	if @customer_name is not null
	begin
		set @customer_name = '%' + @customer_name + '%'
	end
	
	select	distinct
			a.enroll_customer_id,
			a.call_id,
			a.call_count,
			a1.register_date,
			a1.register_datetime,
			call_status = a2.call_category_desc,
			b.customer_name,
			c.sign_date,
			unconfirmed_deal1_yn = isnull(b.unconfirmed_deal1_yn, 0),
			unconfirmed_deal2_yn = isnull(b.unconfirmed_deal2_yn, 0),
			unconfirmed_deal3_yn = isnull(b.unconfirmed_deal3_yn, 0),
			unconfirmed_deal4_yn = isnull(b.unconfirmed_deal4_yn, 0),
			unconfirmed_deal5_yn = isnull(b.unconfirmed_deal5_yn, 0),
			unconfirmed_deal6_yn = isnull(b.unconfirmed_deal6_yn, 0)
	from	(	
				select	a.enroll_customer_id,
						call_id = max(b.call_id),
						call_count = isnull(count(b.call_id), 0)
				from	enroll_customer a
						left outer join csr_call b on a.enroll_customer_id = b.enroll_customer_id
				where	a.enroll_customer_status = 'N' or 
						a.enroll_customer_status not in ('X', 'I', 'U', 'C', 'D', 'Z') 
				group by a.enroll_customer_id	
			) a				
			inner join
			(
				select	enroll_customer_id,
						customer_name = name2,
						unconfirmed_deal1_yn = dbo.fget_csr_unconfirm_deal_select_yn(enroll_customer_id, 1),
						unconfirmed_deal2_yn = dbo.fget_csr_unconfirm_deal_select_yn(enroll_customer_id, 2),
						unconfirmed_deal3_yn = dbo.fget_csr_unconfirm_deal_select_yn(enroll_customer_id, 3),
						unconfirmed_deal4_yn = dbo.fget_csr_unconfirm_deal_select_yn(enroll_customer_id, 4),
						unconfirmed_deal5_yn = dbo.fget_csr_unconfirm_deal_select_yn(enroll_customer_id, 5),
						unconfirmed_deal6_yn = dbo.fget_csr_unconfirm_deal_select_yn(enroll_customer_id, 6)
				from	enroll_customer 
				where	enroll_customer_status = 'N' or 
						enroll_customer_status not in ('X', 'I', 'U', 'C', 'D', 'Z')
			) b on a.enroll_customer_id = b.enroll_customer_id
			inner join
			(
				select	sign_date = min(a.sign_date),
						b.enroll_customer_id
				from	enroll_customer_site_contract a, enroll_customer_site b
				where	a.enroll_site_id = b.enroll_site_id
				group by b.enroll_customer_id
			) c on a.enroll_customer_id = c.enroll_customer_id
			left outer join csr_call a1 on a.call_id = a1.call_id 
			left outer join csr_call_category a2 on a1.call_category_id = a2.call_category_id
	
	where	(@customer_name is null or b.customer_name like @customer_name) and
			(@call_count_begin is null or @call_count_begin <= call_count) and
			(@call_count_end is null or call_count <= @call_count_end) and
			(@date_begin is null or @date_begin <= a1.register_date) and
			(@date_end is null or a1.register_date <= @date_end) and
			not 
			(
				isnull(b.unconfirmed_deal1_yn, 0) = @deal1_yn and
				isnull(b.unconfirmed_deal2_yn, 0) = @deal2_yn and
				isnull(b.unconfirmed_deal3_yn, 0) = @deal3_yn and
				isnull(b.unconfirmed_deal4_yn, 0) = @deal4_yn and
				isnull(b.unconfirmed_deal5_yn, 0) = @deal5_yn and
				isnull(b.unconfirmed_deal6_yn, 0) = @deal6_yn
			)
	
END

/*
select	distinct
			a.enroll_customer_id,
			a.call_id,
			a.register_date,
			a.register_datetime,
			call_status = a1.call_category_desc,
			b.customer_name,
			unconfirmed_deal1_yn = isnull(b.unconfirmed_deal1_yn, 0),
			unconfirmed_deal2_yn = isnull(b.unconfirmed_deal2_yn, 0),
			unconfirmed_deal3_yn = isnull(b.unconfirmed_deal3_yn, 0),
			unconfirmed_deal4_yn = isnull(b.unconfirmed_deal4_yn, 0),
			unconfirmed_deal5_yn = isnull(b.unconfirmed_deal5_yn, 0),
			unconfirmed_deal6_yn = isnull(b.unconfirmed_deal6_yn, 0),
			c.call_count,
			d.sign_date
	from	(	
				select	a.enroll_customer_id,
						a.call_id,
						a.register_date,
						a.register_datetime,
						call_category_id						
				from	csr_call a,
						enroll_customer b 
				where	a.enroll_customer_id = b.enroll_customer_id and
						b.enroll_customer_status = 'N' or 
						b.enroll_customer_status not in ('X', 'I', 'U', 'C', 'D', 'Z')
			) a				
			inner join
			(
				select	enroll_customer_id,
						customer_name = name2,
						unconfirmed_deal1_yn = dbo.fget_csr_unconfirm_deal_select_yn(enroll_customer_id, 1),
						unconfirmed_deal2_yn = dbo.fget_csr_unconfirm_deal_select_yn(enroll_customer_id, 2),
						unconfirmed_deal3_yn = dbo.fget_csr_unconfirm_deal_select_yn(enroll_customer_id, 3),
						unconfirmed_deal4_yn = dbo.fget_csr_unconfirm_deal_select_yn(enroll_customer_id, 4),
						unconfirmed_deal5_yn = dbo.fget_csr_unconfirm_deal_select_yn(enroll_customer_id, 5),
						unconfirmed_deal6_yn = dbo.fget_csr_unconfirm_deal_select_yn(enroll_customer_id, 6)
				from	enroll_customer 
				where	enroll_customer_status = 'N' or 
						enroll_customer_status not in ('X', 'I', 'U', 'C', 'D', 'Z')
			) b on a.enroll_customer_id = b.enroll_customer_id
			inner join
			(
				select	a.enroll_customer_id,
						call_id = max(a.call_id),
						call_count = isnull(count(a.call_id), 0)
				from	csr_call a,
						enroll_customer b
				where	a.enroll_customer_id = b.enroll_customer_id
				group by a.enroll_customer_id	
			) c on a.call_id = c.call_id
			inner join
			(
				select	a.sign_date,
						b.enroll_customer_id
				from	enroll_customer_site_contract a, enroll_customer_site b
				where	a.enroll_site_id = b.enroll_site_id
			) d on a.enroll_customer_id = d.enroll_customer_id
			inner join csr_call_category a1 on a.call_category_id = a1.call_category_id
	where	(@customer_name is null or customer_name like @customer_name) and
			(@call_count_begin is null or @call_count_begin <= call_count) and
			(@call_count_end is null or call_count <= @call_count_end) and
			(@date_begin is null or @date_begin <= a.register_date) and
			(@date_end is null or a.register_date <= @date_end) and
			not (
				isnull(b.unconfirmed_deal1_yn, 0) = @deal1_yn and
				isnull(b.unconfirmed_deal2_yn, 0) = @deal2_yn and
				isnull(b.unconfirmed_deal3_yn, 0) = @deal3_yn and
				isnull(b.unconfirmed_deal4_yn, 0) = @deal4_yn and
				isnull(b.unconfirmed_deal5_yn, 0) = @deal5_yn and
				isnull(b.unconfirmed_deal6_yn, 0) = @deal6_yn
			)
*/