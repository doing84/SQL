USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.21
-- Description:
-- Author:		CHOI
-- Create date: 2016.07.28
-- Description:		
-- =============================================
ALTER PROCEDURE [dbo].[set_contact_score_rate]
@contact_id		int,
@score_rate		int = null
AS
BEGIN

	SET NOCOUNT ON;
	
	update	contact
	set		score_rate = @score_rate
	where	contact_id = @contact_id and
			(@score_rate is null or @score_rate between 0 and 10)
	
	if @@ERROR <> 0 or @@ROWCOUNT = 0
	begin
		
		raiserror('Error, invalid request!', 16, 1)
		return -1
		
	end
	
END