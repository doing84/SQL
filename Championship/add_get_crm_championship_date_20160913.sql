USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.13
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_get_crm_championship_date]
@championship_name		varchar(100),
@date_begin				date,
@date_end				date
AS
BEGIN

	SET NOCOUNT ON
	
	insert into crm_championship
	(
		championship_name,
		date_begin,
		date_end
	)
	values
	(
		@championship_name,
		@date_begin,
		@date_end
	)
				
END

