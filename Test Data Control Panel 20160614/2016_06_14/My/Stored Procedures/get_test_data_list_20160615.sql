USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_test_data_list]    Script Date: 06/16/2016 15:35:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.15
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_test_data_list]
@customer_name			varchar(50) = null,
@enroll_site_id			int = null,
@enroll_customer_id		int = null,
@update_id	            int = null,
@update_date            datetime = null,
@register_id			int = null,
@register_date			date = null			
AS
BEGIN

	SET NOCOUNT ON;
	
	if @customer_name is not null
	begin
		set @customer_name = '%' + @customer_name + '%'
	end
			
	select	b.enroll_site_id,
			c.enroll_customer_id,
			customer_name = b.short_name,
			count_edi_log = dbo.fget_test_data_edi_log_count(a.enroll_site_id),
			a.update_id,
			a.update_date,
			a.register_id,
			a.register_time
	from	test_data a
			inner join enroll_customer_site b on a.enroll_site_id = b.enroll_site_id
			left outer join enroll_customer c on b.enroll_customer_id = c.enroll_customer_id
	where	(@enroll_site_id is null or a.enroll_site_id = @enroll_site_id) and
			(@update_id	is null or a.update_id = @update_id) and
			(@update_date is null or a.update_date = @update_date) and
			(@enroll_customer_id is null or b.enroll_customer_id = @enroll_customer_id) and
			(@customer_name is null or c.last_name like @customer_name) and
			(@register_id is null or a.register_id = @register_id) and
			(@register_date is null or a.register_date = @register_date)
END

