USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[del_enroll_customer_site_test]    Script Date: 06/20/2016 13:57:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.06.17
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[del_enroll_customer_site_test]
@enroll_site_id	int,
@register_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	delete
	from	enroll_customer_site_test
	where	enroll_site_id = @enroll_site_id and
			register_id = @register_id and
			test_status = 'I'
			
	if @@ERROR <> 0 or @@ROWCOUNT = 0
	begin
		raiserror('Error, invalid request!', 16, 1)
		return -1
	end
	
END

