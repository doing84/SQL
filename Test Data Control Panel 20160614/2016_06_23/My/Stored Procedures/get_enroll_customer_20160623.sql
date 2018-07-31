USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_enroll_customer]    Script Date: 06/23/2016 15:45:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2014.05.21
-- Review date: 2016.03.18
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_enroll_customer]
@enroll_customer_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	*
	from	enroll_customer
	where	enroll_customer_id = @enroll_customer_id
	
END

