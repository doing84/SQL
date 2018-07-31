USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2015.07.04
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[set_employment_applicant_file_name]
@applicant_id	int,
@file_name		varchar(50)
AS
BEGIN

	SET NOCOUNT ON;
	
	update	employment_applicant
	set		[file_name] = @file_name,
			update_date = getdate()
    where	applicant_id = @applicant_id
    
END


