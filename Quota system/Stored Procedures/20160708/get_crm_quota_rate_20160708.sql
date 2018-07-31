USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_crm_quota_rate]    Script Date: 07/08/2016 11:42:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.07
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_quota_rate]
@quota_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	*
	from	crm_quota_rate
	where	quota_id = @quota_id
	
END

