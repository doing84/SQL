USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_lifetime_rce_enrolled]    Script Date: 08/02/2016 17:06:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		SKC
-- Create date: 2016.08.02
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_lifetime_rce_enrolled]
(
	@login_id	int
)
RETURNS float
AS
BEGIN

	DECLARE	@ResultVar float
	
	select	@ResultVar = sum(total_rce)
	from	(
				select	a.enroll_site_id,
						total_rce = a.total_rce
				from	enroll_customer_site a,
						(
							select	login_id
									--sister_id = login_id
							from	[login]
							where	login_id = @login_id and
									account_type = 'U'
							union
							select	a.login_id
									--b.sister_id
							from	[login] a,
									login_pie b
							where	a.login_id = b.login_id and
									b.sister_id = @login_id and
									a.account_type = 'G'
						) a1,
						enroll_customer b
				where	a.agent_id = a1.login_id and
						a.enroll_customer_id = b.enroll_customer_id and
						a.total_rce is not null and
						--a.enroll_site_status not in ('C', 'Z') and
						a.enroll_site_status in ('G', 'X', 'Y') and
						b.enroll_customer_status not in ('I', 'X', 'Z')
				union
				select	a.enroll_site_id,
						total_rce = a.total_rce
				from	enroll_customer_site a,
						(
							select	login_id
									--sister_id = login_id
							from	[login]
							where	login_id = @login_id and
									account_type = 'U'
							union
							select	a.login_id
									--b.sister_id
							from	[login] a,
									login_pie b
							where	a.login_id = b.login_id and
									b.sister_id = @login_id and
									a.account_type = 'G'
						) a1,
						--[login] a2,
						enroll_customer b
				where	a.manager_id = a1.login_id and
						--a1.sister_id = a2.login_id and
						--a2.[login_type] = 'T' and
						a.enroll_customer_id = b.enroll_customer_id and
						a.total_rce is not null and
						--a.enroll_site_status not in ('C', 'Z') and
						a.enroll_site_status in ('G', 'X', 'Y') and
						b.enroll_customer_status not in ('I', 'X', 'Z')
			) a
	
	RETURN	@ResultVar
	
END


