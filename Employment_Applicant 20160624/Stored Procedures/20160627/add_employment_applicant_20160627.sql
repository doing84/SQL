USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[add_employment_applicant]    Script Date: 06/27/2016 23:39:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.24
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[add_employment_applicant]
@applicant_name			varchar(100),
@applicant_phone		varchar(20),
@applicant_email		varchar(50),
@job_title				varchar(100),
@applicant_cover_letter	varchar(max)= null
AS
DECLARE
@register_date		date = getdate(),
@register_time		time = getdate()
BEGIN

	SET NOCOUNT ON;
	
	if	@applicant_name		is null and
		@applicant_phone	is null and
		@applicant_email	is null and
		@job_title			is null
	begin
		raiserror('Invalid request!', 16, 1)
		return -1
	end
	
	if exists(select 1 from employment_applicant where applicant_email = @applicant_email)
	begin
	
		update	employment_applicant
		set		applicant_name = @applicant_name,
				applicant_phone = @applicant_phone,
				applicant_email = @applicant_email,
				applicant_cover_letter = @applicant_cover_letter,
				job_title = @job_title,
				update_date = getdate()
		where	(applicant_email = @applicant_email)
	
	end
	else
	begin
	
		insert into employment_applicant
		(
			applicant_name,
			applicant_phone,
			applicant_email,
			register_date,
			register_time,
			job_title,
			applicant_cover_letter
		)
		values
		(
			@applicant_name,
			@applicant_phone,
			@applicant_email,
			@register_date,
			@register_time,
			@job_title,
			@applicant_cover_letter
		)
	end
	
END

