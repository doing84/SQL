USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[add_contact]    Script Date: 07/25/2016 11:53:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.07.25
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[add_contact2]
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
	
	--if exists(select 1 from contact where ip_address = @ip_address and register_date = @register_date)
	if exists
	(
		select	1
		from	contact
		where	contact_type = @contact_type and
				contact_email = @contact_email				
	)
	begin
	
		update	contact
		set		contact_name = @contact_name,
				contact_phone = @contact_phone,
				contact_email = @contact_email,
				contact_desc = @contact_desc,
				update_count = update_count + 1,
				update_date = getdate()
		where	contact_type = @contact_type and
				contact_email = @contact_email
	
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

