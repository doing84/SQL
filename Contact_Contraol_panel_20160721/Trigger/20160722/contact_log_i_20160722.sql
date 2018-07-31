USE [CEW]
GO
/****** Object:  Trigger [dbo].[contact_log_i]    Script Date: 07/22/2016 13:16:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.22
-- Description:	
-- =============================================
ALTER TRIGGER [dbo].[contact_log_i] ON [dbo].[contact_log]
FOR INSERT
AS
BEGIN

	SET NOCOUNT ON;
	
	update	contact
	set		log_count = dbo.fget_contact_log_count(contact_id)
			
END


