USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_login_postal_count]    Script Date: 07/12/2016 16:15:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2015.07.12
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_login_postal_count]
(
	@login_id	int
)
RETURNS int
AS
BEGIN

	DECLARE	@ResultVar	int = 0
	
	select	@ResultVar = count(a.postal_code)
	from	login_postal a,
			zone_postal b
	where	a.login_id = @login_id and
			a.postal_code = b.postal_code
	
	RETURN	@ResultVar
	
END


