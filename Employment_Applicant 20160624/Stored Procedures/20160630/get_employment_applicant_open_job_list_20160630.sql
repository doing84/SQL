USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_employment_applicant_open_job_list]    Script Date: 06/30/2016 09:20:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.24
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[get_employment_applicant_open_job_list]
@job_id	int = null
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.*,	
			b.dept_name
	from	employment_job a
			inner join	company_dept b on a.dept_id = b.dept_id
	where	(@job_id is null or a.job_id = @job_id) and
			(a.job_status <> 'I')
	
END



