USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_contact_list_adv]    Script Date: 07/28/2016 11:01:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.21
-- Description:	
-- Author:		SKC
-- Create date: 2016.07.26
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_contact_list_adv]
@contact_type		char(1) = null,
@contact_name		varchar(100) = null,
@contact_email		varchar(50) = null,
@contact_phone		varchar(20) = null,
@log_count_begin	int = null,
@log_count_end		int = null,
@score_rate_begin	int	= null,
@score_rate_end		int	= null,
@register_id		int = null,
@date_begin			date = null,
@date_end			date = null,
@update_begin		date = null,
@update_end			date = null
AS
BEGIN

	SET NOCOUNT ON;
	
	if	@contact_name is not null
	begin
		if len(@contact_name) < 1
		begin
			raiserror('Please enter at least 1 letters to complete this request!', 16, 1)
			return -1
		end 
	
		set @contact_name = '%' + @contact_name + '%'
		
	end
	
	if	@contact_email is not null
	begin
		
		if len(@contact_email) < 1
		begin
			raiserror('Please enter at least 1 letters to complete this request!', 16, 1)
			return -2
		end 
	
		set @contact_email = '%' + @contact_email + '%'
		
	end	
	
	if	@contact_phone is not null
	begin
		
		if len(@contact_phone) < 1
		begin
			raiserror('Please enter at least 1 letters to complete this request!', 16, 1)
			return -3
		end 
	
		set @contact_phone = '%' + @contact_phone + '%'
		
	end							
		
	select	a.*,
			register_name = b.full_name
	from	contact a
			left outer join [login] b on a.register_id = b.login_id
	where	(@contact_type is null or a.contact_type = @contact_type) and
			(@contact_name is null or a.contact_name like @contact_name) and
			(@contact_email is null or a.contact_email like @contact_email) and
			(@contact_phone is null or a.contact_phone like @contact_phone) and
			(@log_count_begin is null or @log_count_begin <= a.log_count) and
			(@log_count_end is null or a.log_count <= @log_count_end) and
			(@score_rate_begin is null or @score_rate_begin <= a.score_rate) and
			(@score_rate_end is null or a.score_rate <= @score_rate_end) and
			(@register_id is null or a.register_id = @register_id) and
			(@date_begin is null or @date_begin <= a.register_date) and
			(@date_end is null or a.register_date <= @date_end) and
			(@update_begin is null or @update_begin <= a.update_date) and
			(@update_end is null or a.update_date <= @update_end)
			
END

