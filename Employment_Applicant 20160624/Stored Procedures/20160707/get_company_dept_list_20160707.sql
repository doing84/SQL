USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_company_dept_list]    Script Date: 07/07/2016 12:01:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.04
-- Description:	
--
-- Update:		SKC
-- Create date: 2016.07.07
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_company_dept_list]
AS
BEGIN

	SET NOCOUNT ON;
			
	select	*
	from	company_dept
				
END