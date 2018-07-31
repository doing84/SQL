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
ALTER PROCEDURE [dbo].[get_crm_championship_note]
@detail_id		int
AS
BEGIN

	SET NOCOUNT ON
	
	select	a.*
	from	crm_championship_note a,
			crm_championship_detail b
	where	a.detail_id = b.detail_id and
			a.detail_id = @detail_id

END

