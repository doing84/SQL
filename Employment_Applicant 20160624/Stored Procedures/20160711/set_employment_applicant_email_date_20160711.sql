USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.11
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[set_employment_applicant_email_date]
@applicant_id	int
AS
BEGIN

	SET NOCOUNT ON;
		
	update	employment_applicant
	set		email_date = getdate()
	where	applicant_id = @applicant_id
	
END

