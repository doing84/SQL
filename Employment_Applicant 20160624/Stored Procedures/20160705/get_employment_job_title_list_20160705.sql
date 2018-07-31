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
ALTER PROCEDURE [dbo].[get_employment_job_title_list]
@job_id		char(1) = null,
@job_title	varchar(50) = null
AS
BEGIN

	SET NOCOUNT ON;
			
	select	*
	from	employment_job
	where	(@job_id is null or job_id = @job_id) and
			(@job_title is null or job_title = @job_title)
				
END