USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.04
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[get_company_dept_list]
@dept_id				int = null,
@dept_name				varchar(100) = null
AS
BEGIN

	SET NOCOUNT ON;
			
	select	*
	from	company_dept
	where	(@dept_id is null or dept_id = @dept_id) and
			(@dept_name is null or dept_name = @dept_name)
				
END