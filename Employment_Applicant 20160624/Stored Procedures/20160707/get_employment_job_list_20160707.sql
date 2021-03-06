USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_employment_job_list]    Script Date: 07/07/2016 15:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.28
-- Description:	
--
-- Update:		SKC
-- Create date: 2016.07.07
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_employment_job_list]
@job_id					int = null,
@job_status				char(1) = null,
@register_id			int = null,
@dept_id				int	= null,
@register_date_begin	date = null,
@register_date_end		date = null,
@open_period_begin		date = null,
@open_period_end		date = null	
AS
BEGIN

	SET NOCOUNT ON;
			
	select	a.*,
			register_full_name = a1.full_name,
			job_status_desc = a2.status_desc,
			b.dept_name
	from	employment_job a
			inner join [login] a1 on a.register_id = a1.login_id
			inner join employment_job_status a2 on a.job_status = a2.status_code
			
			inner join company_dept b on a.dept_id = b.dept_id
			
	where	(@job_id is null or a.job_id = @job_id) and
			(@register_date_begin is null or @register_date_begin <= a.register_date) and
			(@register_date_end is null or a.register_date <= @register_date_end) and
			(@job_status is null or a.job_status = @job_status) and
			(@register_id is null or a.register_id = @register_id) and
			(@open_period_begin is null or a.open_period_begin = @open_period_begin) and
			(@open_period_end is null or a.open_period_end = @open_period_end) and
			(@dept_id is null or b.dept_id = @dept_id) 
			
END
