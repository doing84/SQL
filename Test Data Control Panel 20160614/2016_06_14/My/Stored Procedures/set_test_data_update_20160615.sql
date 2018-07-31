USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.15
-- Description:	
-- =============================================
CREATE PROCEDURE set_test_data_update
@enroll_site_id	int,
@update_id		int
AS
BEGIN

	SET NOCOUNT ON;
	
	update	test_data
	set		update_id = @update_id,
			update_date = GETDATE()
	where	enroll_site_id = @enroll_site_id

END


