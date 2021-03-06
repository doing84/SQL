USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[set_crm_championship_detail_status_toActive]    Script Date: 09/21/2016 08:50:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.16
-- Description:	
-- Update:		SKC
-- Update date: 2016.09.20
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[set_crm_championship_detail_status_toActive]
@detail_id	int
AS
DECLARE
@round_id	int = null,
@min_player	int,
@cur_player int
BEGIN

	SET NOCOUNT ON;
	
	/*
	update	crm_championship_detail
	set		detail_status = 'A',
			update_date = getdate()
	where	detail_id = @detail_id
			
	if @@ERROR <> 0 or @@ROWCOUNT = 0
	begin
	
		raiserror('Invalid Requet!', 16, 1)
		return -1
	
	end
	*/
	
	select	@round_id = a.round_id,
			@min_player = b.min_player
	from	crm_championship_detail a,
			crm_championship_round_type b
	where	a.round_id = b.round_id and
			a.detail_id = @detail_id
			
	select	@cur_player = count(seed_id)
	from	crm_championship_seed
	where	login_id is not null and
			detail_id = @detail_id
	
	if @round_id is null or isnull(@min_player, 0) > isnull(@cur_player, 0)
	begin
		raiserror('Invalid Request!', 16, 1)
		return -1
	end
	
	BEGIN TRANSACTION
	
	insert into crm_championship_seed
	(
		detail_id,
		seed_no
	)
	select	a.detail_id,
			b.seed_no
	from	crm_championship_detail a,
			crm_championship_round_type_detail b
	where	a.round_id = b.round_id and
			a.detail_id = @detail_id and
			b.seed_no not in
			(
				select	seed_no
				from	crm_championship_seed
				where	detail_id = @detail_id
			)
	order by sort_seq
	
	if @@ERROR <> 0 --or @@ROWCOUNT = 0
	begin
		ROLLBACK TRANSACTION
		raiserror('crm_championship_seed - Inserting Error', 16, 1)
		return -2
	end
	
	update	crm_championship_detail
	set		detail_status = 'A',
			update_date = getdate()
	where	detail_status = 'I' and
			detail_id = @detail_id
	
	if @@ERROR <> 0 or @@ROWCOUNT = 0
	begin
		ROLLBACK TRANSACTION
		raiserror('crm_championship_detail - Updating Error', 16, 1)
		return -3
	end
	
	update	crm_championship_seed
	set		seed_status = 'A',
			update_date = getdate()
	where	seed_status = 'I' and
			detail_id = @detail_id
	
	if @@ERROR <> 0 or @@ROWCOUNT = 0
	begin
		ROLLBACK TRANSACTION
		raiserror('crm_championship_seed - Updating Error', 16, 1)
		return -4
	end
	
	COMMIT TRANSACTION
	
END
