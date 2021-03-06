USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.05
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[upd_employment_job]
@job_id				int,
@dept_id			int,
@job_title			varchar(100),
@job_desc			varchar(max) = null,
@job_status			char(1),
@open_period_begin	date,
@open_period_end	date,
@register_id		int
AS
BEGIN

	SET NOCOUNT ON;
	
	/*
	if	@dept_id			is null or
		@job_title			is null or
		@job_desc			is null or
		@job_status			is null or
		@open_period_begin	is null or
		@open_period_end	is null 
	begin
		raiserror('Invalid request!', 16, 1)
		return -1
	end
	*/
	
	update	employment_job
	set		dept_id = @dept_id, 
			job_title = @job_title,
			job_desc = @job_desc,
			job_status = @job_status, 
			open_period_begin = @open_period_begin, 
			open_period_end = @open_period_end,
			update_id = @register_id,
			update_date = getdate()
	where	job_id = @job_id
	
END

