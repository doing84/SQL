USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_crm_championship_round]    Script Date: 09/21/2016 08:48:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.15
-- Description:	Modifying
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_championship_round]
--@detail_id			int
AS
DECLARE
@snapshot_id	int
BEGIN

	SET NOCOUNT ON
	
	select	snapshot_id,
			snapshot_date2
	into	#snapshot_ids
	from	crm_bonus_snapshot
	where	snapshot_status = 'A'
	
	select	a.*,
			login_full_name = b.full_name,
			--detail_id = dbo.fget_crm_championship_player_list_detail_id(@detail_id),
			c.seed_no
	from	(
				select	a.snapshot_date2,
						b.login_id,
						b.total_appt,
						b.total_rce
				from	#snapshot_ids a,
						crm_bonus_snapshot_detail b
				where	a.snapshot_id = b.snapshot_id 
			) a 
			inner join [login] b on a.login_id = b.login_id
			left outer join 
			(	select	login_id,
						detail_id,
						seed_no
				from	crm_championship_seed
				--where	detail_id = @detail_id
			) c on a.login_id = c.login_id
	
END

