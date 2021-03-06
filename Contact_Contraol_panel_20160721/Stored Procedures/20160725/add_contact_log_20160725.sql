USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[add_contact_log]    Script Date: 07/25/2016 19:02:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.25
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_contact_log]
@contact_id		int,
@contact_type	char(1),
@contact_name	varchar(100),
@contact_email	varchar(50),
@email_type		char(1),
@contact_phone	varchar(20) = null,
@contact_desc	varchar(1000) = null,
@ip_address		varchar(20),	
@register_id	int = null
AS
DECLARE
@log_id			int
BEGIN

	SET NOCOUNT ON;
	
	insert into contact_log
	(	contact_id,
		contact_type,
		contact_name,
		contact_email,
		email_type,
		contact_phone,
		contact_desc,
		ip_address,
		register_id
	)
	values
	(
		@contact_id,
		@contact_type,
		@contact_name,	
		@contact_email,
		@email_type,
		@contact_phone,	
		@contact_desc,
		@ip_address,
		@register_id
	)
		
	SET @log_id = SCOPE_IDENTITY();

	select	*
	from	contact_log
	where	log_id = @log_id	
	
END

