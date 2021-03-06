USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_crm_championship_seed_appt_toCompare]    Script Date: 09/21/2016 08:54:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		SKC
-- Create date: 2016.09.20
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_crm_championship_seed_appt_toCompare]
(
	@detail_id		int,
	@seed_no		int,
	@snapshot_id	int
)
RETURNS int
AS
BEGIN

	DECLARE	@ResultVar int
	
	if @seed_no % 2 = 1
	begin
		set @seed_no = @seed_no + 1
	end
	else
	begin
		set @seed_no = @seed_no - 1
	end
	
	declare @login_id int
	
	select	@login_id = login_id
	from	crm_championship_seed
	where	detail_id = @detail_id and
			seed_no = @seed_no

	select	@ResultVar = total_appt
	from	crm_bonus_snapshot_detail
	where	snapshot_id = @snapshot_id and
			login_id = @login_id
	
	RETURN	@ResultVar
	
END

