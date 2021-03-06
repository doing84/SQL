USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[run_employment_job_resets]    Script Date: 07/07/2016 16:10:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.07.07
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[run_employment_job_resets]
AS
DECLARE
@today_date	date = getdate()
BEGIN

	SET NOCOUNT ON;
	
	/*
	A: Active
	I: Inactive
	H: Hold
	*/
	
	BEGIN TRANSACTION
	
	update	employment_job
	set		job_status = 'I'
	where	job_status <> 'H'
	
	if @@ERROR <> 0 --or @@ROWCOUNT = 0
	begin
		ROLLBACK TRANSACTION
		raiserror('employment_job - Updating Error 1', 16, 1)
		return -1
	end
	
	update	employment_job
	set		job_status = 'A'
	where	job_status <> 'H' and
			@today_date between open_period_begin and open_period_end

	if @@ERROR <> 0 --or @@ROWCOUNT = 0
	begin
		ROLLBACK TRANSACTION
		raiserror('employment_job - Updating Error 2', 16, 1)
		return -2
	end
	
	COMMIT TRANSACTION

END

