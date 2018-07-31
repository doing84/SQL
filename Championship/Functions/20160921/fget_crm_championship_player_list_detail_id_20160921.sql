USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_crm_championship_player_list_detail_id]    Script Date: 09/21/2016 08:54:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.15
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_crm_championship_player_list_detail_id]
(
	@detail_id	int		
)
RETURNS int
AS
BEGIN

	DECLARE	@ResultVar int
	
	select	@ResultVar = detail_id
	from	crm_championship_detail
	where	detail_id = @detail_id 
	
	RETURN	@ResultVar
	
END



