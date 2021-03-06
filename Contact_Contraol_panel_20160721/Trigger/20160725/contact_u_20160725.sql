USE [CEW]
GO
/****** Object:  Trigger [dbo].[contact_u]    Script Date: 07/25/2016 20:06:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		CHOI
-- Create date: 2017.07.25
-- Description:	
-- =============================================
ALTER TRIGGER [dbo].[contact_u] ON [dbo].[contact]
FOR UPDATE
AS
IF	UPDATE(contact_name)
IF	UPDATE(contact_phone)
IF	UPDATE(contact_desc)
BEGIN

	SET NOCOUNT ON;
	
	
	insert into contact_log
	(
		contact_id,
		contact_type,
		contact_name,
		contact_email,
		contact_phone,
		contact_desc,
		ip_address
	)
	
	select	contact_id,
			contact_type,
			contact_name,
			contact_email,
			contact_phone,
			contact_desc,
			ip_address
	from	inserted
	
   
    
END
