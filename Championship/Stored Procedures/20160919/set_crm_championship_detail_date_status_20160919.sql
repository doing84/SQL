USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[set_crm_championship_detail_date_status]    Script Date: 09/19/2016 12:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[set_crm_championship_detail_date_status]
@detail_id			int,
@date_yn			bit
AS
BEGIN

	SET NOCOUNT ON;
	
	update	crm_championship_detail
	set		date_yn = @date_yn,
			update_date = getdate()
	where	detail_id = @detail_id

END

