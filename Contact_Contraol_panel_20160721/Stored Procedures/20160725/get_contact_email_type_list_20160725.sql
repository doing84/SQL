USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.25
-- Description:	

-- =============================================
CREATE PROCEDURE [dbo].[get_contact_email_type_list]
AS
BEGIN

	SET NOCOUNT ON;
			
	select	*
	from	contact_email_type
					
END

