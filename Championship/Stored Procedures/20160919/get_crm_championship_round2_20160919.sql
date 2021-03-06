USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_crm_championship_round2]    Script Date: 09/19/2016 08:21:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_championship_round2]
AS
DECLARE
@snapshot_id	int
BEGIN

	SET NOCOUNT ON
	
	select	top 1
			@snapshot_id = snapshot_id
	from	crm_bonus_snapshot
	where	snapshot_status = 'A' and
			snapshot_date2 = 
			(
				select	detail_date
				from	crm_championship_detail
			)
	order by snapshot_id desc
	
	select	snapshot_id = @snapshot_id
	
	select	a.*,
			seed_status_desc = a1.status_desc,
			c.full_name,
			c.photo_name,
			round_score = d.total_appt,
			d.total_appt,
			d.total_rce
	from	crm_championship_seed a
			inner join crm_seed_status a1 on a.seed_status = a1.status_code
			inner join crm_championship_detail b on a.detail_id = b.detail_id
			inner join [login] c on a.login_id = c.login_id
			left outer join
			(
				select	a.snapshot_date2,
						b.login_id,
						b.total_appt,
						b.total_rce
				from	crm_bonus_snapshot a,
						crm_bonus_snapshot_detail b
				where	a.snapshot_id = b.snapshot_id and
						a.snapshot_id = @snapshot_id
			) d on a.login_id = d.login_id and b.detail_date = d.snapshot_date2
	
	
END

