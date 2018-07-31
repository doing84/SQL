USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_edi_site_download_count]    Script Date: 06/17/2016 10:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.06.17
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_edi_site_download_count]
(
	@site_id	int
)
RETURNS int
AS
BEGIN

	DECLARE	@ResultVar	int = 0
	
	select	@ResultVar = count(transaction_id)
	from	edi_site_download
	where	site_id = @site_id
	
	RETURN	@ResultVar
	
END

