USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_crm_championship_login_desc]    Script Date: 09/15/2016 20:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.15
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_crm_championship_login_desc]
(
	@login_id		int = null		
)
RETURNS varchar(50)
AS
BEGIN

	DECLARE	@ResultVar varchar(50)
	
	if @login_id is null
	begin
	
		select	@ResultVar = b.full_name
		from	crm_championship_seed a,
				[login] b
		where	a.login_id = b.login_id and
				a.detail_id = 5
	end
		
	if @login_id is not null
	begin
	
		select	@ResultVar = d.round_desc
		from	crm_championship_seed a,
				[login] b,
				crm_championship_detail c,
				crm_championship_round_type d
		where	a.login_id = b.login_id and
				a.detail_id = c.detail_id and
				c.round_id = d.round_id and
				a.login_id = @login_id
						
	end
	
	RETURN	@ResultVar
	
END



