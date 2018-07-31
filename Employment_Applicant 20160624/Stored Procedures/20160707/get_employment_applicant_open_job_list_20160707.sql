USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_employment_applicant_open_job_list]    Script Date: 07/07/2016 11:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.24
-- Description:	
--
-- Update:		SKC
-- Update date: 2016.07.07
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_employment_applicant_open_job_list]
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.*,	
			b.dept_name
	from	employment_job a
			inner join	company_dept b on a.dept_id = b.dept_id
	where	a.job_status = 'A'
	
END

