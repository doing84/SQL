USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[del_employment_job]    Script Date: 09/13/2016 15:01:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Update date: 2016.09.13
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[del_crm_championship_date]
@championship_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	if exists(select 1 from crm_championship_detail where championship_id = @championship_id)
	begin
		raiserror('Error, this record is locked!', 16, 1)
		return -1
	end
	
	delete
	from	crm_championship
	where	championship_id = @championship_id
	
END

