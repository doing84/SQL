USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_contact_log_count]    Script Date: 07/22/2016 11:00:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.21
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_contact_log_count]
(
	@contact_id	int
)
RETURNS int
AS
BEGIN

	DECLARE	@ResultVar	int = 0
	
	select	@ResultVar = count(log_id)
	from	contact_log
	where	contact_id = @contact_id	
	
	RETURN	@ResultVar
	
END

