USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.07
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[set_employment_applicant_status]
@applicant_id		int,
@applicant_status	char(1)

AS
BEGIN

	SET NOCOUNT ON;
		
	update	employment_applicant
	set		applicant_status = @applicant_status
	where	applicant_id = @applicant_id
	
END

