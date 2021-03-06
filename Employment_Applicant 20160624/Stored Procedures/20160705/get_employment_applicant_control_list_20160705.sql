USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.24
-- Update date: 2016.06.28
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_employment_applicant_control_list]
@search_string		varchar(100) = null,
@job_id				int = null,
@job_status			char(1) = null,
@applicant_id		int = null,
@applicant_status	char(1) = null,
@register_id		int = null,
@dept_id			int	= null,
@date_begin			date = null,
@date_end			date = null,
@open_period_begin	date = null,
@open_period_end	date = null	
AS
BEGIN

	SET NOCOUNT ON;
			
	if	@search_string is not null
	begin
		if len(@search_string ) < 1
		begin
			raiserror('Please enter at least 1 letters to complete this request!', 16, 1)
			return -2
		end 
	
		set @search_string = '%' + @search_string + '%'
		
	end		
	
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
			
	where	(@applicant_id is null or a.applicant_id = @applicant_id ) and
			(@job_id is null or a.job_id = @job_id) and
			(@applicant_status is null or a.applicant_status = @applicant_status) and
			(@search_string is null or a.applicant_name like @search_string) and
			(@date_begin is null or @date_begin <= a.applicant_register_date) and
			(@date_end is null or a.applicant_register_date <= @date_end) and
			(@open_period_begin is null or @open_period_begin <= b.open_period_begin) and
			(@open_period_end is null or b.open_period_end <= @open_period_end) and
			(@job_status is null or b.job_status = @job_status) and
			(@register_id is null or b1.login_id = @register_id) and
			(@dept_id is null or c.dept_id = @dept_id) 
			
END