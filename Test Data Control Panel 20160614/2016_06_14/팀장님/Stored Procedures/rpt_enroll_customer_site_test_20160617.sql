USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_enroll_customer_site_test]    Script Date: 06/17/2016 10:07:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SKC
-- Create date: 2016.06.17
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_enroll_customer_site_test]
@search_string		varchar(50) = null,
@enroll_site_id		int = null,
@enroll_customer_id	int = null
AS
BEGIN

	SET NOCOUNT ON;
	
	if	@search_string is null and
		@enroll_site_id	is null and
		@enroll_customer_id	is null
	begin
		raiserror('Invalid request!', 16, 1)
		return -1
	end		
	
	if	@search_string is not null
	begin
	
		if len(@search_string ) < 3
		begin
			raiserror('Please enter at least 3 letters to complete this request!', 16, 1)
			return -2
		end 
	
		set @search_string = '%' + @search_string + '%'
		
	end
	
	select	a.enroll_customer_id,
			a.enroll_site_id,
			site_name = a.name2,
			customer_name = b.name2,
			count_edi_log = dbo.fget_edi_site_upload_count(a.enroll_site_id) + dbo.fget_edi_site_download_count(a.enroll_site_id)
	from	enroll_customer_site a
			inner join enroll_customer b on a.enroll_customer_id = b.enroll_customer_id
	where	(a.enroll_site_id not in (select enroll_site_id from enroll_customer_site_test)) and 
			(@enroll_customer_id is null or a.enroll_customer_id = @enroll_customer_id) and
			(@enroll_site_id is null or a.enroll_site_id = @enroll_site_id) and
			(
				@search_string is null or
				a.name2 like @search_string or
				b.name2 like @search_string
			)	

END
