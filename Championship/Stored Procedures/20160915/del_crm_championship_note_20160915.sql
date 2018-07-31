USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[del_crm_championship_note]    Script Date: 09/15/2016 20:39:36 ******/
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

