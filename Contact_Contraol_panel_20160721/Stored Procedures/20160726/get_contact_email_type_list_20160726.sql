USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_contact_email_type_list]    Script Date: 07/26/2016 16:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.25
-- Description:	

-- =============================================
ALTER PROCEDURE [dbo].[get_contact_email_type_list]
AS
BEGIN

	SET NOCOUNT ON;
			
	select	*
	from	contact_email_type
					
END

