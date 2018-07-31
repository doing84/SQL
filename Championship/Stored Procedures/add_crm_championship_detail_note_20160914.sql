USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.14
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_crm_championship_note]
@detail_id		int,
@note_desc		varchar(200),
@register_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	insert into crm_championship_note
	(
		detail_id,
		note_desc,
		register_id
	)
	values
	(
		@detail_id,
		@note_desc,
		@register_id
	)
    
END

