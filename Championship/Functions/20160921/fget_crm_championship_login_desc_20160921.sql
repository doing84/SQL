USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_crm_championship_login_desc]    Script Date: 09/21/2016 08:54:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.15
-- Description:	
-- Update:		SKC
-- Update date: 2016.09.16
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_crm_championship_login_desc]
(
	@championship_id	int,
	@login_id			int = null		
)
RETURNS varchar(50)
AS
BEGIN

	DECLARE	@ResultVar varchar(50) = null
	
	if @login_id is null
	begin
	
		select	top 1
				@ResultVar = 'Winner: ' + c.full_name
		from	crm_championship_detail a,
				crm_championship_seed b,
				[login] c
		where	a.detail_id = b.detail_id and
				b.login_id = c.login_id and
				a.championship_id = @championship_id and
				a.round_id = 1
	
	end
	else
	begin
	
		select	top 1
				@ResultVar = a1.round_desc
		from	crm_championship_detail a,
				crm_championship_round_type a1,
				crm_championship_seed b
		where	a.round_id = a1.round_id and
				a.detail_id = b.detail_id and
				a.championship_id = @championship_id and
				b.login_id = @login_id
		order by a1.round_id
	
	end
	
	if @ResultVar is null
	begin
	
		select	@ResultVar = 'Total ' + convert(varchar, count(detail_id)) + ' Round(s)'
		from	crm_championship_detail
		where	championship_id = @championship_id and
				round_id is not null
	
	end
	
	RETURN	@ResultVar
	
END



