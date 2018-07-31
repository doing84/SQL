USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.08
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[del_crm_quota_rate]
@quota_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	delete
	from	crm_quota_rate
	where	quota_id = @quota_id
	
END

