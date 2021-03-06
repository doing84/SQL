USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_contact_list_adv]    Script Date: 07/21/2016 21:41:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.21
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_contact_list_adv]
@contact_name	varchar(100) = null,
@contact_email	varchar(50) = null,
@log_count		int = null,
@score_rate		int	= null,
@date_begin		date = null,
@date_end		date = null
AS
BEGIN

	SET NOCOUNT ON;
	
	if	@contact_name is not null
	begin
		if len(@contact_name) < 1
		begin
			raiserror('Please enter at least 1 letters to complete this request!', 16, 1)
			return -2
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
	
	select	distinct a.*
																			
	from	contact a
			left outer join contact_log a1 on a.contact_id = a1.contact_id
			left outer join [login] b on a1.login_id = b.login_id
	
	where	(@contact_name is null or a.contact_name like @contact_name) and
			(@contact_email is null or a.contact_email like @contact_email) and
			(@date_begin is null or @date_begin <= a.register_date) and
			(@date_end is null or a.register_date <= @date_end) and
			(@log_count is null or log_count = @log_count) and
			(@score_rate is null or a.score_rate = @score_rate) 
	
END

