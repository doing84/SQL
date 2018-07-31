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
ALTER PROCEDURE [dbo].[get_login_postal_code_list]
@search_string	varchar(100) = null
AS
BEGIN

	SET NOCOUNT ON;
	
	if @search_string is not null
	begin
		set @search_string = '%' + @search_string + '%'
	end
		
	select  a.postal_code,
			a.zone_id,
			a1.zone_desc
	from	postal a
			inner join zone a1 on  a.zone_id = a1.zone_id
			
	where	(a.postal_status = 'A') and
			(@search_string is null or a1.zone_desc like @search_string) and
			(a.postal_code not in(select postal_code from login_postal))
									
END

