USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.15
-- Description:	for detail information of phone no
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_login_postal_phone]
@provider_id			int,
@phone					varchar(20)
AS
BEGIN

	SET NOCOUNT ON;
	
	select  a.*,
			a1.*,
			b.call_category_desc
	from	crm_postal a
			inner join login_postal a1 on a.postal_code = a1.postal_code
			inner join crm_call_category b on a1.call_category_id = b.call_category_id
	where	a.provider_id = @provider_id and
			a.phone1 = @phone
									
END
