USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_crm_championship_seed_list3]    Script Date: 09/21/2016 08:49:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.09.20
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_championship_seed_list3]
@detail_id		int
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
				where	detail_id = @detail_id
			)
	order by snapshot_id desc
	
	select	snapshot_id = @snapshot_id
	
	select	a.*,
			seed_status_desc = a1.status_desc,
			c.full_name,
			d.total_appt,
			d.total_rce,
			total_appt2 = dbo.fget_crm_championship_seed_appt_toCompare(a.detail_id, a.seed_no, @snapshot_id),
			total_rce2 = dbo.fget_crm_championship_seed_rce_toCompare(a.detail_id, a.seed_no, @snapshot_id)
	from	crm_championship_seed a
			inner join crm_seed_status a1 on a.seed_status = a1.status_code
			inner join crm_championship_detail b on a.detail_id = b.detail_id
			inner join [login] c on a.login_id = c.login_id
			left outer join
			(
				select	a.snapshot_date2,
						b.login_id,
						b.total_appt,
						--b.total_rce
						total_rce = b.total_rces
				from	crm_bonus_snapshot a,
						crm_bonus_snapshot_detail b
				where	a.snapshot_id = b.snapshot_id and
						a.snapshot_id = @snapshot_id
			) d on a.login_id = d.login_id and b.detail_date = d.snapshot_date2
	where	a.detail_id = @detail_id
	
END

