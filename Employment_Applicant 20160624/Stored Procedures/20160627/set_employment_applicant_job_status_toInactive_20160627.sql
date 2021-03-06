USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[set_employment_applicant_job_status_toInactive]    Script Date: 06/28/2016 00:54:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2015.06.27
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[set_employment_applicant_job_status_toInactive]
@job_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	update	employment_applicant_job
	set		job_status = 'I',
			update_date = getdate()
    where	job_status = 'A' and
			job_id = @job_id
    
END


