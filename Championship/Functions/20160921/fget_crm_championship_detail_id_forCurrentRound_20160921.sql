USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_crm_championship_detail_id_forCurrentRound]    Script Date: 09/21/2016 08:52:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.09.19
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_crm_championship_detail_id_forCurrentRound]
(
	@championship_id	int
)
RETURNS int
AS
BEGIN

	DECLARE	@ResultVar int
	
	select	top 1
			@ResultVar = detail_id
	from	crm_championship_detail
	where	championship_id = @championship_id and
			round_id is not null and
			detail_status = 'I' and
			date_yn = 1
	--order by round_id desc
	order by detail_id
	
	RETURN	@ResultVar
	
END


