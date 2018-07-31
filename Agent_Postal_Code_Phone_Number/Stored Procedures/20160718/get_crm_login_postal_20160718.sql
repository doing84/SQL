USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.15
-- Description:	for checking assigned phone no
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_login_postal]
@login_id				int,
@provider_id			int = null,
@call_category_id		int = null,
@phone_no					varchar(20) = null

AS
BEGIN

	SET NOCOUNT ON;
	
	if @phone_no is not null
	begin
		set @phone_no = '%' + @phone_no + '%'
	end
		
	select  a.*,
			a1.provider_id,
			a1.business_name,
			a1.phone1,
			a1.phone2,
			b.call_category_desc
	from	login_postal a
			inner join crm_postal a1 on a.postal_code = a1.postal_code
			inner join crm_call_category b on a.call_category_id = b.call_category_id
	where	(a.login_id = @login_id) and
			(@call_category_id is null or a.call_category_id = @call_category_id) and
			(@provider_id is null or a1.provider_id = @provider_id) and
			(@phone_no is null or a1.phone1 like @phone_no)
									
END
