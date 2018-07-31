USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[set_crm_quota_rate_template_file_name]    Script Date: 07/11/2016 07:41:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.07
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[set_crm_quota_rate_template_file_name]
@quota_id			int,
@template_file_name	varchar(50)
AS
BEGIN

	SET NOCOUNT ON;
	
	update	crm_quota_rate
	set		template_file = @template_file_name
	where	quota_id = @quota_id
	
END

