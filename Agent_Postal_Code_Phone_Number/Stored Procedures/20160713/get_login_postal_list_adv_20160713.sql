USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.12
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_login_postal_list_adv]
@login_id			int = null,
@agent_type			char(1) = null,
@emp_type			char(1) = null
AS
BEGIN

	SET NOCOUNT ON;
		
	select  a.full_name,
			a.emp_type,
			a.[login_type],
			a1.login_id,
			postal_code_count = dbo.fget_login_postal_count(a1.login_id),
			login_type_desc = a2.type_desc,
			emp_type_desc = a3.type_desc
	from	[login] a
			inner join 
			(
				select	distinct
						login_id
				from	login_postal
			) a1 on a.login_id = a1.login_id
			inner join [login_type] a2 on a.[login_type] = a2.type_code
			inner join emp_type a3 on a.emp_type = a3.type_code
	where	(@agent_type is null or a.[login_type] = @agent_type) and
			(@emp_type is null or a.emp_type = @emp_type) and
			(@login_id is null or a1.login_id = @login_id)
							
END