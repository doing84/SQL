USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.24
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_employment_applicant_list]
@register_id	int = null
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.*,	
			b.[file_name],
			b.file_note
	from	employment_applicant a
			left outer join	employment_applicant_file b on a.applicant_id = b.register_id
	where	(@register_id is null or b.register_id = @register_id)
	
END


