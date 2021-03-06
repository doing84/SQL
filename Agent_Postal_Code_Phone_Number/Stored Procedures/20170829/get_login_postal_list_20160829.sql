USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_login_postal_list]    Script Date: 08/29/2016 14:54:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.12
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_login_postal_list]
@login_id	int
AS
BEGIN

	SET NOCOUNT ON;
			
	select  full_name = a.full_name,
			a1.postal_code,
			a1.register_date,
			a1.register_time,
			a1.update_date,
			b.*,
			b1.country_desc,
			b2.province_desc
	from	[login] a
			left outer join [login_postal] a1 on a.login_id = a1.login_id
			left outer join zone_postal a2 on a1.postal_code = a2.postal_code
			left outer join zone b on a2.zone_id = b.zone_id
			left outer join country b1 on b.country_id = b1.country_id
			left outer join province b2 on b.province_id = b2.province_id 
	where	a.login_id = @login_id
	
END


--select  a.postal_code,
--		a.register_date,
--		a.register_time,
--		a.update_date,
--		full_name = a1.full_name,
--		b.*,
--		b1.country_desc,
--		b2.province_desc
--from	[login_postal] a
--		inner join [login] a1 on a.login_id = a1.login_id
--		inner join postal a2 on a.postal_code = a2.postal_code
--		inner join zone b on a2.zone_id = b.zone_id
--		inner join country b1 on b.country_id = b1.country_id
--		inner join province b2 on b.province_id = b2.province_id 
--where	a1.login_id = @login_id