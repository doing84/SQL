USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[set_enroll_customer_site_test_status_toActive]    Script Date: 06/23/2016 15:53:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.06.17
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[set_enroll_customer_site_test_status_toActive]
@enroll_site_id	int,
@update_id		int
AS
BEGIN

	SET NOCOUNT ON;
	
	update	enroll_customer_site_test
	set		test_status = 'A',
			update_id = @update_id,
			update_date = getdate()
	where	test_status = 'I' and
			enroll_site_id = @enroll_site_id
	
	if @@ERROR <> 0 or @@ROWCOUNT = 0
	begin
		raiserror('Error, invalid request!', 16, 1)
		return -1
	end
	
END

