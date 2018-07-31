USE [CEW]
GO
/****** Object:  Trigger [dbo].[contact_log_i]    Script Date: 07/22/2016 13:16:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.25
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[contact_log_email_i] ON [dbo].[contact_log]
FOR INSERT
AS
BEGIN

	SET NOCOUNT ON;
	
	update	contact
	set		email_count = dbo.fget_contact_log_email_count(contact_id)
			
END


