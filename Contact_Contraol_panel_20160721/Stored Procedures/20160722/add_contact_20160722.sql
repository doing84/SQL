USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[add_contact]    Script Date: 07/22/2016 11:25:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.04.27
-- Update date: 2016.06.28
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_contact]
@contact_type	char(1),
@contact_name	varchar(100),
@contact_phone	varchar(20) = null,
@contact_email	varchar(50),
@contact_desc	varchar(1000) = null,
@ip_address		varchar(20)
AS
DECLARE
@contact_id		int,
@register_date	date = getdate()
BEGIN

	SET NOCOUNT ON;
	
	if exists(select 1 from contact where ip_address = @ip_address and register_date = @register_date)
	begin
	
		update	contact
		set		contact_type = @contact_type,
				contact_name = @contact_name,
				contact_phone = @contact_phone,
				contact_email = @contact_email,
				contact_desc = @contact_desc,
				update_date = getdate()
		where	ip_address = @ip_address and
				register_date = @register_date
	
	end
	else
	begin
	
		insert into contact
		(
			contact_type,
			contact_name,
			contact_phone,
			contact_email,
			contact_desc,
			ip_address
		)
		values
		(
			@contact_type,
			@contact_name,
			@contact_phone,
			@contact_email,
			@contact_desc,
			@ip_address
		)
		
		/*
		SET @contact_id = SCOPE_IDENTITY();	

		select	*
		from	contact
		where	contact_id = @contact_id
		*/
	end
	
END

