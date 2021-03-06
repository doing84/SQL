USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[add_employment_applicant]    Script Date: 07/07/2016 14:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.24
-- Update date: 2016.07.06
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_employment_applicant]
@applicant_name				varchar(100),
@applicant_phone			varchar(20),
@applicant_email			varchar(50),
@job_id						int,
@file_name					varchar(50) = null,
@applicant_cover_letter		varchar(max)= null,
@ip_address					varchar(20)
AS
DECLARE
@applicant_id				int = null
BEGIN
	
	SET NOCOUNT ON;
		
	select	@applicant_id = max(applicant_id)
	from	employment_applicant
	where	applicant_email = @applicant_email and
			ip_address = @ip_address and
			job_id = @job_id
	
	if		@applicant_id is not null
	begin
	
		update	employment_applicant
		set		applicant_name = @applicant_name,
				applicant_phone = @applicant_phone,
				applicant_email = @applicant_email,
				[file_name] = @file_name,
				applicant_cover_letter = @applicant_cover_letter,
				ip_address = @ip_address
		where	applicant_id = @applicant_id
		
	end
	else
	begin
	
		insert into employment_applicant
		(
			applicant_name,
			applicant_phone,
			applicant_email,
			job_id,
			[file_name],
			applicant_cover_letter,
			ip_address	
		)
		values
		(
			@applicant_name,
			@applicant_phone,
			@applicant_email,
			@job_id,
			@file_name,
			@applicant_cover_letter,
			@ip_address	
		)
		
		SET @applicant_id = SCOPE_IDENTITY();
	
	end
	
	select	*
	from	employment_applicant
	where	applicant_id = @applicant_id
		
END

