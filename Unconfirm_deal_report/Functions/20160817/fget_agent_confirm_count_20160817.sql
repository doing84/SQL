USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_agent_confirm_count]    Script Date: 08/17/2016 16:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.17
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_agent_confirm_count]
(
	@login_id	int	
)
RETURNS float
AS
BEGIN

	DECLARE	@ResultVar int
	
	select	@ResultVar = count(enroll_customer_id)
	from	enroll_customer
	where	enroll_customer_status = 'C' and
			(
				agent_id = @login_id or
				manager_id = @login_id
			)
		
	RETURN	@ResultVar
	
END

