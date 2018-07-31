USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_enroll_customer_site_test]    Script Date: 06/17/2016 09:38:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.06.17
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_enroll_customer_site_test]
@enroll_site_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	*
	from	enroll_customer_site_test
	where	enroll_site_id = @enroll_site_id
	
END

