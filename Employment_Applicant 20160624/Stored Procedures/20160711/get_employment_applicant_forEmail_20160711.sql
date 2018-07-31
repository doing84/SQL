USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOi
-- Create date: 2015.07.11
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_employment_applicant_forEmail]
@applicant_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.*,
						
			b.job_title,
			b.job_desc,
			b.open_period_begin,
			b.open_period_end,
			b1.dept_name,
			b1.dept_email
	from	employment_applicant a
			inner join employment_job b on a.job_id = b.job_id
			inner join company_dept b1 on b.dept_id = b1.dept_id
	where	a.applicant_id = @applicant_id
	
END

