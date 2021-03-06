USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[addupd_crm_championship_seed]    Script Date: 09/19/2016 11:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.15
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[addupd_crm_championship_seed]
@detail_id	int,
@login_id	int,
@seed_no	int = null
AS
DECLARE
@update_date	datetime = getdate(),
@seed_count		int = 0
BEGIN

	SET NOCOUNT ON;
	
	select	@login_id = login_id
	from	crm_bonus_snapshot_detail
	where	login_id = @login_id
	
	--select	@seed_count = count(seed_no)
	--from	crm_championship_seed
			
	if @seed_no > 16 or @seed_no = 0
	begin
	
		raiserror('Invalid Requet!', 16, 1)
		return -1
	
	end
		
	if exists(select 1 from crm_championship_seed where detail_id = @detail_id and seed_no = @seed_no)
	begin
		
		raiserror('Invalid Requet!', 16, 1)
		return -2
						
	end
	
	--if exists(select 1 from crm_championship_detail where detail_id = @detail_id and round_id < @seed_count)
	--begin
		
	--	raiserror('Invalid Requet!', 16, 1)
	--	return -3
						
	--end
	
	if exists(select 1 from crm_championship_seed where detail_id = @detail_id and login_id = @login_id )
	begin
		
		update	crm_championship_seed
		set		seed_no = @seed_no,
				update_date = @update_date
		where	login_id = @login_id
						
	end
	else 
	begin
		
		insert into crm_championship_seed
		(
			detail_id,
			login_id,
			seed_no			
		)
		values
		(
			@detail_id,
			@login_id,
			@seed_no
		)	
	
	end
	
END

