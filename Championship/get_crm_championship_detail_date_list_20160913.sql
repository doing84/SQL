USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_crm_championship_player_list]    Script Date: 09/13/2016 15:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.13
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_championship_detail_date_list]1
@championship_id	int
AS
BEGIN

	SET NOCOUNT ON
	
	select	a.championship_id,
			a.detail_id,
			total_seed = a.round_id,
			a.detail_date,
			a.date_yn,
			a1.min_player,
			a1.round_desc
	from	crm_championship_detail a
			left outer join crm_championship_round_type a1 on a.round_id = a1.round_id
			inner join crm_championship b on a.championship_id = b.championship_id 
	where	a.championship_id = @championship_id
		
END

