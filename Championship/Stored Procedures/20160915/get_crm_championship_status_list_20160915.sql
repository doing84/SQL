USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_crm_championship_status_list]    Script Date: 09/15/2016 20:41:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2015.03.19
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_championship_status_list]
AS
BEGIN

	SET NOCOUNT ON;

	select	*
	from	crm_championship_status
   
END

