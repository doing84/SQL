USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[set_crm_championship_status_toActive]    Script Date: 09/16/2016 19:28:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.16
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[set_crm_championship_detail_status_toActive]
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
