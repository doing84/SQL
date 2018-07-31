USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2015.07.18
-- Description:	for updating status of phone no
-- =============================================
ALTER PROCEDURE [dbo].[set_crm_login_postal_status]
@login_id			int,
@postal_code		varchar(10),
@call_category_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	update	login_postal
	set		call_category_id = @call_category_id,
			update_date = getdate()
	where	login_id = @login_id and
			postal_code = @postal_code
	
END

