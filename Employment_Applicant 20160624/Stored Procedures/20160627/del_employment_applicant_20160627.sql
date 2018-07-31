USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.27
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[del_employment_applicant]
@applicant_id	int,
@update_id		int
AS
BEGIN

	SET NOCOUNT ON;
	
	delete
	from	employment_applicant
	where	applicant_id = @applicant_id and
			update_id = @update_id
									
	if @@ERROR <> 0 or @@ROWCOUNT = 0
	begin
		raiserror('Error, invalid request!', 16, 1)
		return -1
	end
	
END

