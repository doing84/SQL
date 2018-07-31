USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.21
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_contact_log_list]
@contact_id		int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.login_id,
			a.log_desc,
			a.contact_email,
			a.email_type,
			a.register_date,
			a.register_time,
			email_type_desc = a1.type_desc,			
			agent_name = b.full_name
	from	contact_log a
			inner join contact_email_type a1 on a.email_type = a1.type_code
			left outer join [login] b on a.login_id = b.login_id
	where	a.contact_id = @contact_id	
		
END

