USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[set_crm_championship_status_toActive]    Script Date: 09/21/2016 08:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[set_crm_championship_status_toActive]
@championship_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	update	crm_championship
	set		championship_status = 'A',
			update_date = getdate()
	where	championship_status <> 'A' and
			championship_id = @championship_id
			
	if @@ERROR <> 0 or @@ROWCOUNT = 0
	begin
	
		raiserror('Invalid Requet!', 16, 1)
		return -1
	
	end

END
