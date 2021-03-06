USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_login_postal_list]    Script Date: 07/12/2016 15:03:49 ******/
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
			
	select  a.*,
			full_name = a1.full_name,
			b.*,
			b1.country_desc,
			b2.province_desc
	from	[login_postal] a
			inner join [login] a1 on a.login_id = a1.login_id
			inner join postal a2 on a.postal_code = a2.postal_code
			inner join zone b on a2.zone_id = b.zone_id
			inner join country b1 on b.country_id = b1.country_id
			inner join province b2 on b.province_id = b2.province_id 
	where	a.login_id = @login_id
	
END

