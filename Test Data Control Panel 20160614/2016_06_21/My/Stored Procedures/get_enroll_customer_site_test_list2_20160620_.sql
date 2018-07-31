USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_enroll_customer_site_test_list]    Script Date: 06/20/2016 08:18:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SKC
-- Create date: 2016.06.17
-- Update date: 2016.06.20
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_enroll_customer_site_test_list2]
@search_string				varchar(50) = null,
@enroll_site_id				int = null,
@enroll_customer_id			int = null,
@test_status				char(1) = null,
@enroll_customer_status		char(1) = null,
@enroll_site_status			char(1) = null,
@register_id				int = null,
@date_begin					date = null,
@date_end					date = null
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.*,
			test_status_desc = a1.status_desc,
			b.enroll_site_status,
			enroll_site_status_desc = a1.status_desc,
			register_full_name = a2.full_name,
			update_full_name = a3.full_name,
			site_name = b.name2,
			c.enroll_customer_status,
			enroll_customer_status_desc = b1.status_code,
			c.enroll_customer_id,
			customer_name = c.name2,
			count_edi_log = dbo.fget_edi_site_upload_count(a.enroll_site_id) + dbo.fget_edi_site_download_count(a.enroll_site_id)
	from	enroll_customer_site_test a
			inner join status_codes a1 on a.test_status = a1.status_code
			inner join [login] a2 on a.register_id = a2.login_id
			left outer join [login] a3 on a.update_id = a3.login_id
			inner join enroll_customer_site b on a.enroll_site_id = b.enroll_site_id
			inner join enroll_site_status a4 on b.enroll_site_status = a4.status_code
			inner join enroll_customer c on b.enroll_customer_id = c.enroll_customer_id
			inner join enroll_customer_status b1 on c.enroll_customer_status = b1.status_code
	where	(
				@search_string is null or
				b.name2 like @search_string or
				c.name2 like @search_string
			) and
			(@enroll_site_id is null or a.enroll_site_id = @enroll_site_id) and
			(@enroll_customer_id is null or c.enroll_customer_id = @enroll_customer_id) and
			(@test_status is null or a.test_status = @test_status) and
			(@enroll_site_status is null or b.enroll_site_status = @enroll_site_status) and
			(@enroll_customer_status is null or c.enroll_customer_status = @enroll_customer_status) and
			(@register_id is null or a.register_id = @register_id) and
			(@date_begin is null or @date_begin <= a.register_date) and
			(@date_end is null or a.register_date <= @date_end)

END
