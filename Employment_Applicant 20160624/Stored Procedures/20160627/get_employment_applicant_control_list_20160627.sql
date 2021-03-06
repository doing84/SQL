USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_employment_applicant_control_list]    Script Date: 06/27/2016 20:13:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.24
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[get_employment_applicant_control_list]
@search_string	varchar(100) = null,
@job_title		varchar(100) = null,
@job_status		char(1) = null,
@applicant_id	int = null,
@update_id		int = null,
@dept_id		int	= null,
@date_begin		date = null,
@date_end		date = null,
@open_period	date = null	
		
AS
BEGIN

	SET NOCOUNT ON;
			
	if	@search_string is not null
	begin
		if len(@search_string ) < 3
		begin
			raiserror('Please enter at least 3 letters to complete this request!', 16, 1)
			return -2
		end 
	
		set @search_string = '%' + @search_string + '%'
		
	end		
	
	select	a.*,
			
			b.job_title,
			b.job_status,
			b.update_id
			
			
	from	employment_applicant a
			
			inner join employment_applicant_job b on a.job_id = b.job_id
			inner join [login] b1 on b.update_id = b1.login_id
			
			inner join company_dept c on b.dept_id = c.dept_id
			
	where	(@applicant_id is null or a.applicant_id = @applicant_id ) and
			(@job_title is null or b.job_title = @job_title) and
			(@job_status is null or b.job_status = @job_status) and
			(@update_id is null or b1.login_id = @update_id) and
			(@dept_id is null or c.dept_id = @dept_id) and
			(@date_begin is null or @date_begin <= a.update_date) and
			(@date_end is null or a.update_date <= @date_end) and
			(@search_string is null or a.applicant_name like @search_string)

	
END


