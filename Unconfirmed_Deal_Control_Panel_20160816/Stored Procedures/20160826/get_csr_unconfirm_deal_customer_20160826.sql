USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_csr_unconfirm_deal_customer]    Script Date: 08/26/2016 19:13:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.18
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_csr_unconfirm_deal_customer] 
@enroll_customer_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	customer_id,
			customer_name = name2
	from	enroll_customer
	where	@enroll_customer_id = @enroll_customer_id
	
END

