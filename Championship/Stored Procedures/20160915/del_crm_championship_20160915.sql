USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[del_crm_championship]    Script Date: 09/15/2016 20:39:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.13
-- Description:
-- Author:		CHOI
-- Update date: 2016.09.15
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[del_crm_championship]
@championship_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	if exists(select 1 from crm_championship where championship_id = @championship_id and championship_status in ('A', 'C'))
	begin
		raiserror('Error, this record is locked!', 16, 1)
		return -1
	end
	
	delete
	from	crm_championship
	where	championship_id = @championship_id
	
END

