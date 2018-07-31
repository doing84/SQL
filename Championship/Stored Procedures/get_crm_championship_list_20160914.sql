USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.13
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_championship_list]
@login_id				int = null,
@championship_status	char(1) = null,
--@date_count				int = null,
@date_begin				date = null,
@date_end				date = null
AS
BEGIN

	SET NOCOUNT ON
	
	select	distinct
			a.*,
			championship_status_desc = a1.status_desc,
			date_count = 0,
			login_desc = 'test'
	from	crm_championship a,
			crm_championship_status a1,
			crm_championship_seed c
	where	a.championship_status = a1.status_code and 
			(@championship_status is null or a.championship_status = @championship_status) and
			(@login_id is null or c.login_id = @login_id) and
			(@date_begin is null or @date_begin <= a.date_begin and
			@date_end is null or a.date_end <= @date_end) 

END

