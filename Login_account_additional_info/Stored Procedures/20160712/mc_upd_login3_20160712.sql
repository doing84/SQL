USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[mc_upd_login3]    Script Date: 07/12/2016 09:37:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.07
-- Description:
-- =============================================
ALTER PROCEDURE [dbo].[mc_upd_login3]
@login_id			int,
@province_id		int,
@login_email		varchar(50),
@login_pswd			varchar(20),
@login_type			char(1),
@login_status		char(1),
@account_type		char(1),
@full_name			varchar(50),
@phone1				varchar(20),
@default_page		varchar(100) = null,
@start_date			date = null,
@phone_no			varchar(20) = null,
@phone_ext			varchar(10) = null,
@emp_type			char(1),
@contest_login_id	int = null,
@register_id		int,
@official_name		varchar(50) = null,
@business_name		varchar(100) = null,
@sin_no				varchar(20) = null,
@postal_code		varchar(10) = null,
@identification_no	varchar(50) = null,
@business_no		varchar(50) = null,
@hst_no				varchar(50) = null,
@address1			varchar(50) = null,
@address2			varchar(50) = null,
@quota_week			numeric(9,2) = null,
@probation_yn		bit
AS
BEGIN

	SET NOCOUNT ON;
	
	update	cesc.dbo.[login]
	set		province_id = @province_id,
			login_email = @login_email,
			login_pswd = @login_pswd,
			login_type = @login_type,
			login_status = @login_status,
			account_type = @account_type,
			full_name = @full_name,
			phone1 = @phone1,
			--default_page = @default_page,
			start_date = @start_date,
			phone_no = @phone_no,
			phone_ext = @phone_ext,
			--register_id = @register_id,
			update_date = getdate()
	where	login_id = @login_id
	
	--exec cesc.dbo.sync_login
	
	update	[login]
	set		province_id = @province_id,
			login_email = @login_email,
			login_pswd = @login_pswd,
			login_type = @login_type,
			login_status = @login_status,
			account_type = @account_type,
			full_name = @full_name,
			phone1 = @phone1,
			default_page = @default_page,
			start_date = @start_date,
			phone_no = @phone_no,
			phone_ext = @phone_ext,
			emp_type = @emp_type,
			contest_login_id = @contest_login_id,
			register_id = @register_id,
			official_name = @official_name,
			business_name = @business_name,
			sin_no = @sin_no,
			postal_code = @postal_code,
			identification_no = @identification_no,
			business_no = @business_no,
			hst_no	= @hst_no,
			address1 = @address1,
			address2 = @address2,
			quota_week = @quota_week,
			probation_yn = @probation_yn,		
			update_date = getdate()
	where	login_id = @login_id

END
