USE [CEW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.16
-- Description:	
-- =============================================
ALTER FUNCTION fget_test_data_edi_log_count
(
	@site_id	int
)
RETURNS int
AS
BEGIN

	DECLARE	@Result	int = 0

	/*
	select	@Result=(select	count(transaction_id)
	from	edi_site_upload
	where	site_id = a.enroll_site_id)
	+
	(select count(transaction_id)
	from	edi_site_download
	where	site_id = a.enroll_site_id)
	*/
	
	set @Result = 
		(
			select	count(transaction_id)
			from	edi_site_upload
			where	site_id = @site_id
		)
		+
		(
			select	count(transaction_id)
			from	edi_site_download
			where	site_id = @site_id
		)
	
	RETURN	@Result
	
END
