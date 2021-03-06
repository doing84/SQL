USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[set_crm_championship_detail_status_toActive]    Script Date: 09/19/2016 12:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[set_crm_championship_detail_status_toActive]
@detail_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	update	crm_championship_detail
	set		detail_status = 'A',
			update_date = getdate()
	where	detail_id = @detail_id
			
	if @@ERROR <> 0 or @@ROWCOUNT = 0
	begin
	
		raiserror('Invalid Requet!', 16, 1)
		return -1
	
	end

END
