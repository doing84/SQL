USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.06
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[get_employment_open_job_desc]
@job_id		int
AS
BEGIN

	SET NOCOUNT ON;
			
	select	*
	from	employment_job
	where	(job_id = @job_id) and
			(job_status = 'A')
				
END

