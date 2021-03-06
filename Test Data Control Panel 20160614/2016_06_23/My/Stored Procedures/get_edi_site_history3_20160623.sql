USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_edi_site_history3]    Script Date: 06/23/2016 15:49:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2015.12.17
-- Review date: 2016.03.18
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_edi_site_history3]
@enroll_site_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.status_code,
			a.status_text,
			a.usage_begin,
			a.usage_end,
			a.actual_usage,
			a.contract_date,
			b.start_date,
			a.cancel_date,
			a.price_date,
			a.register_date,
			a.register_time,
			register_datetime = cast(a.register_date as datetime) + cast(a.register_time as datetime)
	into	#get_edi_site_history
	from	edi_site_download a
			left outer join enroll_customer_site_contract b on a.contract_id = b.enroll_contract_id
	where	a.site_id = @enroll_site_id
	
	insert into #get_edi_site_history	
	select	status_code = a.transaction_code,
			status_text = a.account_number,
			usage_begin = null,
			usage_end = null,
			actual_usage = null,
			contract_date = null,
			--b.start_date,
			start_date = null,
			cancel_date = null,
			price_date = null,
			a.register_date,
			a.register_time,
			register_datetime = cast(a.register_date as datetime) + cast(a.register_time as datetime)
	from	edi_site_upload a
			left outer join enroll_customer_site_contract b on a.contract_id = b.enroll_contract_id
	where	a.site_id = @enroll_site_id
	
	select	*
	from	#get_edi_site_history
	--order by register_date, register_time

END


