USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[set_crm_championship_detail_status_toClose]    Script Date: 09/21/2016 08:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.09.20
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[set_crm_championship_detail_status_toClose]
@detail_id		int,
@snapshot_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	if exists
	(
		select	1
		from	crm_championship_seed
		where	seed_status in ('I', 'A') and
				detail_id = @detail_id
	)
	begin
		raiserror('Invalid Requet!', 16, 1)
		return -1
	end
	
	update	crm_championship_detail
	set		detail_status = 'C',
			snapshot_id = @snapshot_id,
			update_date = getdate()
	where	detail_status = 'A' and
			detail_id = @detail_id
	
	if @@ERROR <> 0 or @@ROWCOUNT = 0
	begin
		raiserror('crm_championship_detail - Updating Error', 16, 1)
		return -2
	end
	
END
