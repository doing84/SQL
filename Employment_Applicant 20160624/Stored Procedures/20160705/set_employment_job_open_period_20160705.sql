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
ALTER PROCEDURE [dbo].[set_employment_job_open_period]
@job_id					int 
AS
DECLARE
@now_date	date = getdate()
BEGIN

	SET NOCOUNT ON;
		
	if exists
	(
		select	1
		from	employment_job
		where	(job_id = @job_id) and
				(open_period_end < @now_date)
					)
	begin
		update	employment_job
		set		job_status = 'I'
		where	job_status = 'A' and
				(job_id = @job_id)
	end
	else
	if exists
	(
		select	1
		from	employment_job
		where	(job_id = @job_id) and
				(open_period_end > @now_date)
					)
	begin
		update	employment_job
		set		job_status = 'A'
		where	job_status = 'I' and
				(job_id = @job_id)
	end
	    
END