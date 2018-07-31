USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[del_crm_championship_date]    Script Date: 09/14/2016 18:25:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Update date: 2016.09.14
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[del_crm_championship_note]
@detail_id	int,
@note_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	delete	
	from	crm_championship_note
	where	detail_id = @detail_id and
			note_id = @note_id
	
END

