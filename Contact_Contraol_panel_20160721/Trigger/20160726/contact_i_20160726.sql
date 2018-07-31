USE [CEW]
GO

/****** Object:  Trigger [dbo].[contact_i]    Script Date: 07/26/2016 15:41:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.25
-- Description:	
-- Author:		SKC
-- Create date: 2016.07.26
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[contact_i] ON [dbo].[contact]
FOR INSERT 
AS
BEGIN

	SET NOCOUNT ON;
	
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

GO


