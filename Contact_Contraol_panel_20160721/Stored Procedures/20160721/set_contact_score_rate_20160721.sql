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
-- =============================================
ALTER PROCEDURE [dbo].[set_contact_score_rate]
@contact_id		int,
@score_rate		int
AS
BEGIN

	SET NOCOUNT ON;
	
	update	contact
	set		score_rate = @score_rate,
			update_date = getdate()
	where	contact_id = @contact_id	

END

