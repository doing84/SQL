USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.27
-- Update date: 2016.06.28
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[set_employment_applicant_job_status_toHold]
@job_id		int,
@update_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	update	employment_applicant_job
	set		job_status = 'H',
			update_id = @update_id,
			update_date = getdate()
    where	job_status = 'A' and
			job_id = @job_id
			
	if @@ERROR <> 0 or @@ROWCOUNT = 0
	begin
		raiserror('Error, invalid request!', 16, 1)
		return -1
	end
    
END


