USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_employment_applicant_open_job_list]    Script Date: 06/29/2016 08:09:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.24
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_employment_applicant_open_job_list]
@job_id	int = null
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.*,
			b.dept_name
	from	employment_applican_job a
			left outer join	company_dept b on a.dept_id = b.dept_id
	where	(@job_id is null or a.job_id = @job_id)
	
END



