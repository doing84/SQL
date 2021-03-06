USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[set_crm_championship_seed_status]    Script Date: 09/21/2016 08:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.09.20
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[set_crm_championship_seed_status]
@seed_id			int,
@seed_status_old	char(1),
@seed_status_new	char(1),
@register_id		int
AS
BEGIN

	SET NOCOUNT ON;
	
	update	crm_championship_seed
	set		seed_status = @seed_status_new,
			register_id = @register_id,
			update_date = getdate()
	where	seed_id = @seed_id and
			seed_status = @seed_status_old
			
	if @@ROWCOUNT = 0
	begin
		raiserror('Error, the record(s) have been changed by another application!', 16, 1)
		return -1
	end
	
END

