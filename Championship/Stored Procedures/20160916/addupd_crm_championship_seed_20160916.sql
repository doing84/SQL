USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[addupd_crm_championship_seed]    Script Date: 09/16/2016 10:19:40 ******/
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
@seed_id	int,
@seed_no	int = null
AS
DECLARE
@update_date datetime = getdate()
BEGIN

	SET NOCOUNT ON;
	
	if @seed_no > 16
	begin
	
		raiserror('Invalid Requet!', 16, 1)
		return -1
	
	end
	
	if exists(select 1 from crm_championship_seed where detail_id = @detail_id and seed_no = @seed_no)
	begin
		
		raiserror('Invalid Requet!', 16, 1)
		return -2
						
	end
	
	if exists(select 1 from crm_championship_seed where detail_id = @detail_id and seed_id = @seed_id)
	begin
		
		update	crm_championship_seed
		set		seed_no = @seed_no,
				update_date = @update_date
		where	seed_id = @seed_id
						
	end
	else if @seed_no is null
	begin
		
		insert into crm_championship_seed
		(
			seed_no
		)
		values
		(
			@seed_no
		)	
	
	end
	
END

