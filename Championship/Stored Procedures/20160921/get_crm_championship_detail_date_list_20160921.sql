USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_crm_championship_detail_date_list]    Script Date: 09/21/2016 08:43:14 ******/
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
ALTER PROCEDURE [dbo].[get_crm_championship_detail_date_list]
@championship_id	int
AS
BEGIN

	SET NOCOUNT ON
	
	select	a.detail_id,
			total_seed = a.round_id,
			a.detail_date,
			a.date_yn,
			a.detail_status,
			a1.min_player,
			a1.round_desc,
			b.championship_status,
			current_round_detail_id = dbo.fget_crm_championship_detail_id_forCurrentRound(a.championship_id)
	from	crm_championship_detail a
			left outer join crm_championship_round_type a1 on a.round_id = a1.round_id
			inner join crm_championship b on a.championship_id = b.championship_id 
	where	a.championship_id = @championship_id
		
END

