USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[add_crm_championship_snapshot]    Script Date: 09/19/2016 08:18:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.15
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_crm_championship_snapshot]
@detail_id		int
AS
--DECLARE
--@snapshot_id	int
BEGIN

	SET NOCOUNT ON;
					
	insert	into crm_championship_detail
	(	
		snapshot_id
	)
	select	a.snapshot_id
	from	crm_bonus_snapshot a,
			crm_championship_detail b
	where	a.snapshot_date2 = b.detail_date and
			b.detail_id = @detail_id 
		
END

