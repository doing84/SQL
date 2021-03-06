USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[addupd_crm_championship_seed_seq_no]    Script Date: 09/15/2016 07:44:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.13
-- Description:	
-- =============================================

ALTER PROCEDURE [dbo].[addupd_crm_championship_seed_seq_no]
@seed_id		int,
@login_id		int,
@sort_no			int
AS
BEGIN

	SET NOCOUNT ON;
	
	if exists
	(
		select	1
		from	crm_championship_seed
		where	login_id = @login_id and
				sort_no = @sort_no
	)
	begin
	
		update	crm_championship_seed
		set		sort_no = @sort_no
		where	seed_id = @seed_id and
				login_id = @login_id			
	
	end
	else
	begin
	
		insert into crm_championship_seed
		(
			sort_no			
		)
		values
		(
			@sort_no
		)
	
	end
		
END

