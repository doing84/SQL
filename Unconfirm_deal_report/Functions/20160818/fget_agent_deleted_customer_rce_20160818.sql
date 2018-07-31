USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_agent_deleted_customer_rce]    Script Date: 08/18/2016 15:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.17
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_agent_deleted_customer_rce]
(
	@login_id	int	
)
RETURNS float
AS
BEGIN

	DECLARE	@ResultVar float
	
	select	@ResultVar = sum(b.total_est_rce)
	from	enroll_customer a,
			enroll_customer_site b
	where	a.enroll_customer_id = b.enroll_customer_id and
			a.enroll_customer_status = 'Z' and
			b.total_rce is not null and
			(
				a.agent_id = @login_id or
				a.manager_id = @login_id
			)
		
	RETURN	@ResultVar
	
END

