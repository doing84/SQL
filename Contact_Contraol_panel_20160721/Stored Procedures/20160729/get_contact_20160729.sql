USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_contact_list]    Script Date: 07/29/2016 09:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.21
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[get_contact_list]
@contact_id		int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	*
	from	contact
	where	contact_id = @contact_id
	
END

