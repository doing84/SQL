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
CREATE PROCEDURE [dbo].[get_employment_applicant]
@applicant_id		int
AS
BEGIN

	SET NOCOUNT ON;
		
		select      *
		from	employment_applicant
		where	applicant_id = @applicant_id

END

