USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.28
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_employment_job_list]
@job_id				int = null,
@job_status			char(1) = null,
@update_id			int = null,
@dept_id			int	= null,
@date_begin			date = null,
@date_end			date = null,
@open_period		date = null	
AS
BEGIN

	SET NOCOUNT ON;
			
	select	a.*
												
	from	employment_applicant_job a
			left outer join [login] a1 on a.update_id = a1.login_id
			
			left outer join company_dept b on a.dept_id = b.dept_id
			
	where	(@job_id is null or a.job_id = @job_id) and
			(@date_begin is null or @date_begin <= a.update_date) and
			(@date_end is null or a.update_date <= @date_end) and
			(@job_status is null or a.job_status = @job_status) and
			(@update_id is null or a1.login_id = @update_id) and
			(@dept_id is null or b.dept_id = @dept_id) 
			
END