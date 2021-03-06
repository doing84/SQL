USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_crm_championship_tree]    Script Date: 09/21/2016 08:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.09.20
-- Description:
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_championship_tree]
@championship_id	int
AS
BEGIN

	SET NOCOUNT ON
	
	select	a.round_id,
			b.seed_id,
			b.seed_no,
			b.seed_status,
			seed_status_desc = b1.status_desc,
			b.login_id,
			c.full_name,
			c.photo_name,
			total_appt = d.total_appt,
			total_rce = d.total_rces
	from	crm_championship_detail a
			inner join crm_championship_seed b on a.detail_id = b.detail_id and b.seed_no is not null
			inner join crm_seed_status b1 on b.seed_status = b1.status_code
			left outer join [login] c on b.login_id = c.login_id
			left outer join crm_bonus_snapshot_detail d on a.snapshot_id = d.snapshot_id and b.login_id = d.login_id
	where	a.round_id is not null and
			a.championship_id = @championship_id
	order by a.round_id desc, b.seed_no
	
END

