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
ALTER PROCEDURE [dbo].[add_employment_job]
@dept_id			int,
@job_title			varchar(100),
@job_desc			varchar(max) = null,
@job_status			char(1),
@open_period_begin	date,
@open_period_end	date,
@register_id		int
AS
DECLARE
@job_id				int
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
	
	insert into employment_job
	(
		dept_id,
		job_title,
		job_desc,
		job_status,
		open_period_begin,
		open_period_end,
		register_id
	)
	values
	(
		@dept_id,
		@job_title,
		@job_desc,
		@job_status,
		@open_period_begin,
		@open_period_end,
		@register_id
	)
	SET @job_id = SCOPE_IDENTITY();
	
	select	*
	from	employment_job
	where	job_id = @job_id
	
END

