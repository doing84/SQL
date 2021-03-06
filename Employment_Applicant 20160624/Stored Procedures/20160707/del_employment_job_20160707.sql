USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[del_employment_job]    Script Date: 07/07/2016 13:16:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Update date: 2016.07.07
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[del_employment_job]
@job_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	if exists(select 1 from employment_applicant where job_id = @job_id)
	begin
		raiserror('Error, this record is locked!', 16, 1)
		return -1
	end
	
	delete
	from	employment_job
	where	job_id = @job_id
	
END

