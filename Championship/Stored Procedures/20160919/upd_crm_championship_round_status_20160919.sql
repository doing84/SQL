USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[upd_crm_championship_round_status]    Script Date: 09/19/2016 08:23:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[upd_crm_championship_round_status]
@detail_id			int
AS
DECLARE
@snapshot_id	 int
BEGIN

	SET NOCOUNT ON;
	
	select	@snapshot_id = a.snapshot_id
	from	crm_bonus_snapshot a,
			crm_championship_detail b
	where	a.snapshot_date2 = b.detail_date and
			b.detail_id = @detail_id
	
	update	crm_championship_detail
	set		detail_status = 'C',
			snapshot_id = @snapshot_id,
			update_date = getdate()
	where	detail_id = @detail_id
	
END
