USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_crm_championship_player_list]    Script Date: 09/21/2016 08:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.13
-- Description:	
-- Update:		SKC
-- Create date: 2016.09.19
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_championship_player_list]
@detail_id			int,
@snapshot_status	char(1) = null,
@date_begin			date = null,
@date_end			date = null
AS
BEGIN

	SET NOCOUNT ON
	
	/*
	select	snapshot_id,
			snapshot_date2
	into	#snapshot_ids
	from	crm_bonus_snapshot
	where	(@date_begin < snapshot_date and snapshot_date <= @date_end) and
			snapshot_status = 'A'
	
	select	a.*,
			login_full_name = b.full_name,
			detail_id = dbo.fget_crm_championship_player_list_detail_id(@detail_id),
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
				where	detail_id = @detail_id
			) c on a.login_id = c.login_id
	*/
		
	select	a.*,
			login_full_name = b.full_name,
			c.seed_id,
			c.seed_no
	from	(
				select	b.login_id,
						total_appt = sum(b.total_appt),
						--total_rce = sum(b.total_rce)
						total_rce = sum(b.total_rces)
				from	crm_bonus_snapshot a,
						crm_bonus_snapshot_detail b
				where	a.snapshot_id = b.snapshot_id and
						b.detail_status = 'A' and
						--b.pay_yn = 1 and
						(@snapshot_status is null or a.snapshot_status = @snapshot_status) and
						(@date_begin is null or @date_begin <= a.snapshot_date2) and
						(@date_end is null or a.snapshot_date2 <= @date_end)
				group by b.login_id
			) a 
			inner join [login] b on a.login_id = b.login_id and b.login_type = 'T' and b.login_status = 'A' and b.duty_yn = 1
			left outer join 
			(	select	seed_id,
						seed_status,
						detail_id,
						login_id,
						seed_no
				from	crm_championship_seed
				where	detail_id = @detail_id
			) c on a.login_id = c.login_id
	order by a.total_appt desc, a.total_rce desc
											
END
		


