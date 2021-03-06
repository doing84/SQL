USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_crm_championship_player_list]    Script Date: 09/14/2016 17:43:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.13
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_championship_player_list]
@detail_id			int,
@snapshot_status	char(1) = null,
@date_begin			date = null,
@date_end			date = null
AS
DECLARE
@datetime_begin		datetime = null,
@datetime_end		datetime = null
BEGIN

	SET NOCOUNT ON
	
	select	@datetime_begin = min(snapshot_date),
			@datetime_end = max(snapshot_date)
	from	crm_bonus_snapshot
	where	(@snapshot_status is null or snapshot_status = @snapshot_status) and
			(@date_begin is null or @date_begin <= snapshot_date2) and
			(@date_end is null or snapshot_date2 <= @date_end)
	
	select	snapshot_id
	into	#snapshot_ids
	from	crm_bonus_snapshot
	where	(@snapshot_status is null or snapshot_status = @snapshot_status) and
			(@datetime_begin < snapshot_date and snapshot_date <= @datetime_end)
	
	select	a.*,
			login_full_name = b.full_name,
			c.seed_no
	from	(
				select	login_id,
						total_appt = sum(total_appt),
						total_rce = sum(total_rce)
				from	crm_bonus_snapshot_detail
				where	snapshot_id in
				(
					select	snapshot_id
					from	#snapshot_ids
				)
				group by login_id
			) a 
			inner join [login] b on a.login_id = b.login_id
			left outer join 
			(	select	login_id,
						detail_id,
						seed_no
				from	crm_championship_seed
				where	detail_id = @detail_id
			) c on a.login_id = c.login_id 
					
END

