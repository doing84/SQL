USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[add_test_data]    Script Date: 06/16/2016 13:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		CHOI
-- Create date: 2016.06.15
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_test_data]
@enroll_site_id	int,
@register_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	insert into test_data
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


