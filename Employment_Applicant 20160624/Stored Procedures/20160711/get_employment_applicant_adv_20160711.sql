USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_employment_applicant_adv]    Script Date: 07/11/2016 15:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.11
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_employment_applicant_adv]
@applicant_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.*,
			applicant_status_desc = a1.status_desc,
						
			b.job_title,
			b.job_status,
			b.open_period_begin,
			b.open_period_end,
			b.register_id,
			b.register_date,
			b.register_time,
			b.update_id,
			b.update_date,
			job_status_desc = b3.status_desc,
			
								
			c.dept_id,
			c.dept_name
												
	from	employment_applicant a
			left outer join	employment_applicant_status a1 on a.applicant_status = a1.status_code
						
			inner join employment_job b on a.job_id = b.job_id
			inner join [login] b1 on b.register_id = b1.login_id
			left outer join [login] b2 on b.update_id = b2.login_id
			inner join employment_job_status b3 on b.job_status = b3.status_code
			
			inner join company_dept c on b.dept_id = c.dept_id
			
	where	applicant_id = @applicant_id

END

