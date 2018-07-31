USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[del_login_postal]    Script Date: 08/29/2016 13:05:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Update date: 2016.07.12
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[del_login_postal]
@login_id		int,
@postal_code	varchar(10)
AS
BEGIN

	SET NOCOUNT ON;
	
	delete	
	from	login_postal
	where	login_id = @login_id and
			postal_code = @postal_code
	
END