USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_crm_championship_seed_list]    Script Date: 09/19/2016 08:22:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.14
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_championship_seed_list]
@detail_id		int
AS
BEGIN

	SET NOCOUNT ON
	
	select	a.*,
			seed_status_desc = a1.status_desc,
			c.total_appt,
			c.total_rce,
			d.snapshot_id,
			e.full_name
	from	crm_championship_seed a,
			crm_seed_status a1,
			crm_championship_detail b,
			(
				select	b.snapshot_date2,
						total_appt = sum(a.total_appt),
						total_rce = sum(a.total_rce)
				from	crm_bonus_snapshot_detail a, crm_bonus_snapshot b
				where	a.snapshot_id = b.snapshot_id 
				group by b.snapshot_date2
			) c,
			crm_bonus_snapshot d,
			[login] e 
	where	a.seed_status = a1.status_code and
			a.detail_id = b.detail_id and
			a.login_id = e.login_id and
			b.detail_date = c.snapshot_date2 and
			a.detail_id = @detail_id and
			b.detail_status = 'A' and
			d.snapshot_status = 'A'			
	
END

