USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_crm_quota_rate_list]    Script Date: 07/08/2016 11:41:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.07
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_quota_rate_list]
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.*,
			register_full_name = b.full_name
	from	crm_quota_rate a,
			[login] b
	where	a.register_id = b.login_id
	
END

