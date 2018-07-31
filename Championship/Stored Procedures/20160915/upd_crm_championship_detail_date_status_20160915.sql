USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[upd_crm_championship_detail_date_status]    Script Date: 09/15/2016 20:42:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.13
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[upd_crm_championship_detail_date_status]
@detail_id	int,
@date_yn	bit
AS
BEGIN

	SET NOCOUNT ON;
	
	update	crm_championship_detail
	set		date_yn = @date_yn,
			update_date = getdate()
	where	detail_id = @detail_id

END

