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
ALTER PROCEDURE [dbo].[get_employment_applicant_list_forEmail]
AS
BEGIN

	SET NOCOUNT ON;
	
	select	applicant_id
	from	employment_applicant
	where	email_date is null
    
END

