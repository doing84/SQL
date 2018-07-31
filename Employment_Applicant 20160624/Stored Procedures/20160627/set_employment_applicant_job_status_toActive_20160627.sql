USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2015.06.27
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[set_employment_applicant_job_status_toActive]
@job_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	update	employment_applicant_job
	set		job_status = 'A',
			update_date = getdate()
    where	job_status = 'I' and
			job_id = @job_id
    
END


