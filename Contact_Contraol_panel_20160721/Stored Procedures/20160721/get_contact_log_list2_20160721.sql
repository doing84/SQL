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
CREATE PROCEDURE [dbo].[get_contact_log_list2]
@contact_id		int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.login_id,
			a.log_desc,
			a.register_date,
			a.register_time,			
			agent_name = b.full_name
	from	contact_log a
			left outer join [login] b on a.login_id = b.login_id
	where	a.contact_id = @contact_id	
		
END

