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
CREATE PROCEDURE [dbo].[get_employment_applicant_job_list]
@job_id			int = null,
@dept_name		varchar(100) = null,
@update_id		int = null,				
@job_title		varchar(100) = null,
@job_status		char(1) = null,
@dept_id		int	= null,
@date_begin		date = null,
@date_end		date = null,
@open_period	date = null	
		
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.*
	from	employment_applicant_job a
			inner join [login] a1 on a.update_id = a1.login_id
			
			inner join company_dept b on a.dept_id = b.dept_id
			
	where	(@job_id is null or a.job_id = @job_id ) and
			(@dept_name is null or b.dept_name = @dept_name) and
			(@update_id is null or a1.login_id = @update_id) and
			(@job_status is null or a.job_status = @job_status) and
			(@dept_id is null or a.dept_id = @dept_id) and
			(@date_begin is null or @date_begin <= a.update_date) and
			(@date_end is null or a.update_date <= @date_end) and
			(@open_period is null or a.open_period = @open_period)

END


