USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[mc_get_login_list_adv2]    Script Date: 07/08/2016 13:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.06.10
-- Description:	
-- Author:		CHOI
-- Update date: 2016.07.08
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[mc_get_login_list_adv2]
@search_string		varchar(50) = null,
@province_id		int = null,
@login_status		char(1) = null,
@login_type			char(1) = null,
@account_type		char(1) = null,
@emp_type			char(1) = null,
@probation_yn		bit = null
AS
BEGIN

	SET NOCOUNT ON;
	
	if @search_string is not null
	begin
		set @search_string = '%' + @search_string + '%'
	end
	
	select	a.*,
			account_type_desc = a1.type_desc,
			emp_type_desc = a2.type_desc,
			login_type_desc = b.type_desc,
			login_status_desc = c.status_desc,
			parent_full_name = d.full_name
	from	[login] a
			inner join login_account_type a1 on a.account_type = a1.type_code
			inner join emp_type a2 on a.emp_type = a2.type_code
			inner join [login_type] b on a.[login_type] = b.type_code
			inner join status_codes c on a.login_status = c.status_code
			left outer join [login] d on a.parent_login_id = d.login_id
	where	(@province_id is null or a.province_id = @province_id) and
			(@login_status is null or a.login_status = @login_status) and
			(@login_type is null or a.[login_type] = @login_type) and
			(@account_type is null or a.account_type = @account_type) and
			(@emp_type is null or a.emp_type = @emp_type) and
			(@probation_yn is null or a.probation_yn = @probation_yn) and
			(
				@search_string is null or
				a.login_email like @search_string or
				a.full_name like @search_string or
				a.phone1 like @search_string or
				a.phone_no like @search_string or
				a.phone_ext like @search_string
			)
	--order by a.full_name
    
END

