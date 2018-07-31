USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.13
-- Description:	for drop-down menu
-- =============================================
ALTER PROCEDURE [dbo].[get_province_list2]
AS
BEGIN

	SET NOCOUNT ON;
	
	select  *			
	from	province
	where	province_status = 'A'
			
END

