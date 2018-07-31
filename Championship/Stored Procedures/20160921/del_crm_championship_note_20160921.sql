USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[del_crm_championship_note]    Script Date: 09/21/2016 08:42:33 ******/
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

