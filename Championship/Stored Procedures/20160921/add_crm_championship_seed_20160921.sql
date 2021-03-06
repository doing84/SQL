USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[add_crm_championship_seed]    Script Date: 09/21/2016 08:41:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.09.19
-- Update date: 2016.09.20
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_crm_championship_seed]
@detail_id		int,
@login_id		int
AS
DECLARE
@detail_status	char(1),
@round_id		int = null,
@seed_no		int = null
BEGIN

	SET NOCOUNT ON;
	
	if exists
	(
		select	1
		from	crm_championship_seed
		where	detail_id = @detail_id and
				login_id = @login_id
	)
	begin
		raiserror('Duplicate Agent Exists!', 16, 1)
		return -1
	end
	
	select	@detail_status = detail_status,
			@round_id = round_id
	from	crm_championship_detail
	where	detail_id = @detail_id
	
	if @round_id is null or @detail_status <> 'I'
	begin
		raiserror('Invalid Round Info!', 16, 1)
		return -2
	end
	
	select	top 1
			@seed_no = seed_no
	from	crm_championship_round_type_detail
	where	round_id = @round_id and
			seed_no not in
			(
				select	seed_no
				from	crm_championship_seed
				where	--login_id <> @login_id and
						detail_id = @detail_id
			)
	order by sort_seq
	
	if @seed_no is null
	begin
		raiserror('Invalid Round Map Info!', 16, 1)
		return -3
	end
	
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
	
END

