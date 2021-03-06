USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[upd_contact]    Script Date: 07/27/2016 08:24:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.26
-- Description:	
-- Author:		SKC
-- Create date: 2016.07.26
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[upd_contact]
@contact_id		int,
@contact_name	varchar(100),
@contact_email	varchar(50),
@email_type		char(1),
@contact_phone	varchar(20) = null,
@contact_desc	varchar(1000) = null,
@ip_address		varchar(20),	
@register_id	int 
AS
BEGIN

	SET NOCOUNT ON;
	
	update	contact
	set		contact_name = @contact_name,
			contact_phone = @contact_phone,
			contact_email = @contact_email,
			email_type = @email_type,
			contact_desc = @contact_desc,
			update_count = update_count + 1,
			register_id = @register_id,
			update_datetime = getdate()
	where	contact_id = @contact_id

END

