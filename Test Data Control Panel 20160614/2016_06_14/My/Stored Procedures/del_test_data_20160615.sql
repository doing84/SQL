USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[del_test_data]    Script Date: 06/16/2016 15:56:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.15
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[del_test_data]
@enroll_site_id	int,
@login_id		int
AS
BEGIN

	SET NOCOUNT ON;
	
	delete
	from	test_data
	where	enroll_site_id = @enroll_site_id and
			register_id = @login_id
			
	if @@ROWCOUNT = 0
	begin
		raiserror('Invalid request! Deleting Error', 16, 1)
		return -1
	end

END

