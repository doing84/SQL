USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_csr_unconfirm_deal_list_adv]    Script Date: 08/19/2016 07:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_csr_unconfirm_deal_list_adv]
@customer_name		varchar(50) = null,
@call_count_begin	int = null,
@call_count_end		int = null,
@date_begin			date = null,
@date_end			date = null
AS
BEGIN

	SET NOCOUNT ON;
	
	if	@customer_name is not null
	
	begin
		if len(@customer_name ) < 2
		begin
			raiserror('Please enter at least 2 letters to complete this request!', 16, 1)
			return -1
		end 
	
	set @customer_name = '%' + @customer_name + '%'
	
	end
	
	select	a.enroll_customer_id,
			a.call_id,
			a.register_date,
			a.register_datetime,
			b.customer_name,
			b.unconfirmed_deal1_yn,
			b.unconfirmed_deal2_yn,
			b.unconfirmed_deal3_yn,
			b.unconfirmed_deal4_yn,
			b.unconfirmed_deal5_yn,
			b.unconfirmed_deal6_yn,
			c.call_count,
			call_status = d.call_category_desc
	from	csr_call a
			inner join
			(
				select	enroll_customer_id,
						customer_name = name2,
						unconfirmed_deal1_yn,
						unconfirmed_deal2_yn,
						unconfirmed_deal3_yn,
						unconfirmed_deal4_yn,
						unconfirmed_deal5_yn,
						unconfirmed_deal6_yn
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
			inner join csr_call_category d on a.call_category_id = d.call_category_id
	
	where	(@customer_name is null or customer_name like @customer_name) and
			(@call_count_begin is null or @call_count_begin <= call_count) and
			(@call_count_end is null or call_count <= @call_count_end) and
			(@date_begin is null or @date_begin <= a.register_date) and
			(@date_end is null or a.register_date <= @date_end)
order by enroll_customer_id

END

