USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_test_data]    Script Date: 06/16/2016 19:16:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.14
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_test_data]
@customer_name			varchar(50) = null,
@enroll_site_id			int = null,
@enroll_customer_id		int = null
AS
BEGIN

	SET NOCOUNT ON;
	
	if	@customer_name is not null
	begin
		set @customer_name = '%' + @customer_name + '%'
	end
	
	if len(@customer_name ) < 3
	begin
		raiserror('Please enter at least 3 letters to complete this request!', 16, 1)
		return -1
	end 
	
	if	@enroll_site_id	is	null and
		@enroll_customer_id	is	null and
		@customer_name is  null
		
	begin
		raiserror('Invalid Request!', 16, 1)
		return -1
	end		
	else
	begin
	select	a.enroll_customer_id,
			a.enroll_site_id,
			customer_name = b.short_name,
			count_edi_log = dbo.fget_test_data_edi_log_count(a.enroll_site_id)
			
	from	enroll_customer_site a
			inner join enroll_customer b on a.enroll_customer_id = b.enroll_customer_id
	where	(@enroll_site_id = null or a.enroll_site_id not in (select enroll_site_id from test_data)) and 
			(@enroll_customer_id is null or a.enroll_customer_id = @enroll_customer_id) and
			(@enroll_site_id is null or a.enroll_site_id = @enroll_site_id) and
			(@customer_name is null or (b.short_name like @customer_name) and (a.short_name like @customer_name))
	end
	
END

