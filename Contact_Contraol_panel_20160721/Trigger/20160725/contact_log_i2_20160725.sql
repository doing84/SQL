USE [CEW]
GO
/****** Object:  Trigger [dbo].[contact_log_i2]    Script Date: 07/25/2016 15:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.25
-- Description:	
-- =============================================
ALTER TRIGGER [dbo].[contact_log_i2] ON [dbo].[contact_log]
FOR INSERT
AS
DECLARE
@contact_id		int, 
@contact_name	varchar(100),
@contact_email	varchar(50),
@contact_phone	varchar(20),
@contact_desc	varchar(1000),
@update_date	datetime = getdate();
BEGIN

	SET NOCOUNT ON;
	
	select	@contact_id = contact_id,
			@contact_name = contact_name,
			@contact_email = contact_email,
			@contact_phone = contact_phone,
			@contact_desc = contact_desc
	from	inserted
	
	update	contact
	set		contact_name = @contact_name,
			contact_email = @contact_email,
			contact_phone = @contact_phone,
			contact_desc = @contact_desc,
			update_date = @update_date
	from    contact 
	where	contact_id = @contact_id 
			
			
END
