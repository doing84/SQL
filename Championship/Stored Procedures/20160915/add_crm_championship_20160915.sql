USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[add_crm_championship]    Script Date: 09/15/2016 20:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.13
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_crm_championship]
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

