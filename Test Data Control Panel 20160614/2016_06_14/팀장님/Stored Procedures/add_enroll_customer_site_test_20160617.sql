USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[add_enroll_customer_site_test]    Script Date: 06/17/2016 09:37:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.06.17
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_enroll_customer_site_test]
@enroll_site_id	int,
@register_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	insert into enroll_customer_site_test
	(
		enroll_site_id,
		register_id
	)
	values
	(
		@enroll_site_id,
		@register_id
	)
	
END

