USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.24
-- Update date: 2016.06.30
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_employment_applicant]
@applicant_name			varchar(100),
@applicant_phone		varchar(20),
@applicant_email		varchar(50),
@job_id					int,
@file_name				varchar(50) = null,
@applicant_cover_letter	varchar(max)= null
AS
DECLARE
@applicant_id		int,
@applicant_register_date		date = getdate(),
@applicant_register_time		time = getdate()
BEGIN

	SET NOCOUNT ON;
	
	if	@applicant_name		is null or
		@applicant_phone	is null or
		@applicant_email	is null or
		@job_id				is null
	begin
		raiserror('Invalid request!', 16, 1)
		return -1
	end
	/*	
	if exists(select 1 from employment_applicant where applicant_email = @applicant_email)
	begin
	
		update	employment_applicant
		set		@applicant_id = applicant_id,
				applicant_name = @applicant_name,
				applicant_phone = @applicant_phone,
				applicant_email = @applicant_email,
				[file_name] = @file_name,
				applicant_cover_letter = @applicant_cover_letter,
				job_id = @job_id,
				register_date = getdate(),
				register_time = getdate()
		where	(applicant_email = @applicant_email)
	
	end
	else
	begin
	*/
	
	insert into employment_applicant
	(
		applicant_name,
		applicant_phone,
		applicant_email,
		applicant_register_date,
		applicant_register_time,
		job_id,
		[file_name],
		applicant_cover_letter
	)
	values
	(
		@applicant_name,
		@applicant_phone,
		@applicant_email,
		@applicant_register_date,
		@applicant_register_time,
		@job_id,
		@file_name,
		@applicant_cover_letter
	)
	
	SET @applicant_id = SCOPE_IDENTITY();
	
	select	*
	from	employment_applicant
	where	applicant_id = @applicant_id
		
END

