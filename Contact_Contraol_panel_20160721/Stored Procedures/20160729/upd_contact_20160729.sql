USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[upd_contact]    Script Date: 08/03/2016 07:41:31 ******/
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
			email_type = @email_type,
			contact_desc = @contact_desc,
			update_count = update_count + 1,
			register_id = @register_id,
			update_datetime = getdate()
	where	contact_id = @contact_id
	
	if @@ERROR <> 0 or @@ROWCOUNT = 0
		begin
			
			raiserror('Error, invalid request!', 16, 1)
			return -1
			
	end

END

