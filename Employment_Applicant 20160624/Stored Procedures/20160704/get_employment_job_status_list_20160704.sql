USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.04
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_employment_job_status_list]
@status_code		char(1) = null,
@status_desc		varchar(100) = null
AS
BEGIN

	SET NOCOUNT ON;
			
	select	*
	from	employment_job_status
	where	(@status_code is null or status_code = @status_code) and
			(@status_desc is null or user_friendly_desc = @status_desc)
				
END