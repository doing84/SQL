USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_contact_list]    Script Date: 07/26/2016 16:40:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.21
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_contact_list]
@contact_id		int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	*
	from	contact
	where	contact_id = @contact_id
	
END

