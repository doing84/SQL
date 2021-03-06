USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2015.09.16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[set_crm_championship_player_status]
@detail_id		int,
@seed_no		int,
@seed_status	char(1)
AS
BEGIN

	SET NOCOUNT ON;
	
	if	exists(select 1 from crm_championship_seed where detail_id = @detail_id and seed_no = @seed_no and seed_status in ('D'))
	begin
		
		update	crm_championship_seed
		set		seed_status = @seed_status,
				update_date = getdate()
		where	detail_id = @detail_id and
				seed_no = @seed_no
	
	end
	else
	begin
		
		raiserror('Invalid Request!', 16, 1)
		return -1
		
	end		

END


