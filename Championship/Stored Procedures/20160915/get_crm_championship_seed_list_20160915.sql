USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_crm_championship_seed_list]    Script Date: 09/15/2016 20:41:44 ******/
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
			e.full_name
	from	crm_championship_seed a,
			crm_seed_status a1,
			crm_championship_detail b,
			(
				select	login_id,
						total_appt = sum(total_appt),
						total_rce = sum(total_rce)
				from	crm_bonus_snapshot_detail 
				group by login_id
			) c,
			crm_bonus_snapshot d,
			[login] e 
	where	a.seed_status = a1.status_code and
			a.detail_id = b.detail_id and
			a.login_id = c.login_id and
			b.detail_date = d.snapshot_date2 and
			c.login_id = e.login_id and
			a.detail_id = @detail_id and
			b.detail_status = 'A' and
			d.snapshot_status = 'A'			
	
END

