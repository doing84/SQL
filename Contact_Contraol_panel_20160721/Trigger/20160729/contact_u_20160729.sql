USE [CEW]
GO
/****** Object:  Trigger [dbo].[contact_u]    Script Date: 07/29/2016 09:42:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		CHOI
-- Create date: 2017.07.25
-- Description:	
-- Author:		SKC
-- Create date: 2017.07.26
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[contact_u] ON [dbo].[contact]
FOR UPDATE
AS
IF	UPDATE(contact_name)	OR
	UPDATE(contact_phone)	OR
	UPDATE(contact_desc)	OR
	UPDATE(email_type)		OR
	UPDATE(ip_address)		OR
	UPDATE(register_id)
BEGIN

	SET NOCOUNT ON;
	
	if exists
	(
		select	1
		from	inserted a,
				deleted b
		where	a.contact_id = b.contact_id and
				a.contact_name = b.contact_name and
				a.contact_phone = b.contact_phone and
				isnull(a.contact_desc, '') = isnull(b.contact_desc, '') and
				a.email_type = b.email_type and
				a.ip_address = b.ip_address and
				isnull(a.register_id, 0) = isnull(b.register_id, 0)
	) return
	
	insert into contact_log
	(
		contact_id,
		contact_name,
		contact_phone,
		contact_desc,
		email_type,
		ip_address,
		register_id
	)
	select	contact_id,
			contact_name,
			contact_phone,
			contact_desc,
			email_type,
			ip_address,
			register_id
	from	inserted
    
END
