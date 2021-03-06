USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[set_contact_score_rate]    Script Date: 07/25/2016 10:06:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.21
-- Description:
-- Author:		CHOI
-- Create date: 2016.07.22
-- Description:		
-- =============================================
ALTER PROCEDURE [dbo].[set_contact_score_rate]
@contact_id		int,
@score_rate		int
AS
BEGIN

	SET NOCOUNT ON;
	
	if @score_rate >=0 and @score_rate <=10
	begin
	
	update	contact
	set		score_rate = @score_rate
	where	contact_id = @contact_id	
	
	end
	else
	begin
		
		raiserror('Error, invalid request!', 16, 1)
		return -1
		
	end
	
END

