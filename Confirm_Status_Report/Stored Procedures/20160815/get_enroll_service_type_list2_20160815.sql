USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2014.05.23
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[get_enroll_service_type_list2]
AS
BEGIN

	SET NOCOUNT ON;

	select	*
	from	enroll_service_type
	where	type_code <> 'R' 
   
END

