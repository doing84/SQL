USE [CEW]
GO
/****** Object:  Trigger [dbo].[contact_i]    Script Date: 07/25/2016 20:06:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.25
-- Description:	
-- =============================================
ALTER TRIGGER [dbo].[contact_i] ON [dbo].[contact]
FOR INSERT 
AS
DECLARE
@contact_id		int,
@contact_type   char(1),
@contact_name	varchar(100),
@contact_email	varchar(50),
@contact_phone	varchar(20),
@contact_desc	varchar(1000),
@ip_address		varchar(20)

BEGIN

	SET NOCOUNT ON;
	
	select	@contact_id	= contact_id,	
			@contact_type = contact_type,
			@contact_name = contact_name,
			@contact_email = contact_email,
			@contact_phone = contact_phone,
			@contact_desc = contact_desc,
			@ip_address = ip_address
	from	inserted
	
	
	insert into	contact_log
	(
			contact_id,
			contact_type,
			contact_name,
			contact_email,
			contact_phone,
			contact_desc,
			ip_address
	)
	
	values
	(		
			@contact_id,
			@contact_type,
			@contact_name,
			@contact_email,
			@contact_phone,
			@contact_desc,
			@ip_address
	)
	
				
END
