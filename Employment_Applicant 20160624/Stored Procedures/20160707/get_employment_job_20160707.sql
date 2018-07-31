USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_employment_job]    Script Date: 07/07/2016 10:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Update date: 2016.07.07
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[get_employment_job]
@job_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	*
	from	employment_job
	where	job_id = @job_id
	
END

