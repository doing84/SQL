USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[add_contact_log_response_email]    Script Date: 07/22/2016 08:06:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.22
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_contact_log_response_email]
@contact_id		int,
@login_id		int,
@contact_name	varchar(100),
@contact_email	varchar(50),
@contact_phone	varchar(20)= null,
@log_desc		varchar(1000)		
AS
DECLARE
@log_id			int,
@email_type		char(1)
BEGIN

	SET NOCOUNT ON;
	
	 select @email_type = type_code 
	 from contact_email_type 
	 where type_code = 'P'
	 
		insert into contact_log
		(
			contact_id,
			login_id,
			contact_name,
			contact_email,
			contact_phone,
			log_desc,
			email_type
		)
		values
		(
			@contact_id,
			@login_id,
			@contact_name,	
			@contact_email,
			@contact_phone,	
			@log_desc,
			@email_type
		)
		
		SET @log_id = SCOPE_IDENTITY();

	select	*
	from	contact_log
	where	log_id = @log_id	
	
END

