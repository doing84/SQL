USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.13
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_login_postal]
@login_id		int,
@postal_code	varchar(10)
AS
BEGIN

	SET NOCOUNT ON;
	
	if exists(select 1 from login_postal where postal_code = @postal_code)
	begin
		
		raiserror('login_postal - Inserting Error!', 16, 1)
		return -1		
	
	end
	else
	begin
		
		insert into login_postal
		(
			login_id,
			postal_code
		)
		values
		(	
			@login_id,
			@postal_code
		)
	
	end	
	
END

