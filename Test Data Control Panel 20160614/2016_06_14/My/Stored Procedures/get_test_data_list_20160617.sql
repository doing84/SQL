USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.17
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_test_data_list2]
@search_string          varchar(50) = null,
@enroll_site_id			int = null,
@enroll_customer_id		int = null,
@update_id	            int = null,
@update_date            datetime = null,
@register_id			int = null,
@register_date			datetime = null			
AS
BEGIN

	SET NOCOUNT ON;
	
	 if    @search_string is not null
      begin  

            if len(@search_string ) < 3
            begin
                  raiserror('Please enter at least 3 letters to complete this request!', 16, 1)
                  return -2
            end   

            set @search_string = '%' + @search_string + '%'
            
      end

			
	select	b.enroll_site_id,
			c.enroll_customer_id,
			site_name =	 b.name2,
			customer_name = c.name2,
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
			(@register_id is null or a.register_id = @register_id) and
			(@register_date is null or a.register_date = @register_date) and
			
				(
                        @search_string is null  or

                        b.name2 like @search_string or

                        c.name2 like @search_string

				)     
END


