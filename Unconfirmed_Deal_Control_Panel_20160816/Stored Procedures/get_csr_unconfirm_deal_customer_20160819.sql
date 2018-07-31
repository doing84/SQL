USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.18
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[get_csr_unconfirm_deal_customer]
@enroll_customer_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	select	enroll_customer_id,
			customer_name = name2,
			unconfirmed_deal1_yn,
			unconfirmed_deal2_yn,
			unconfirmed_deal3_yn,
			unconfirmed_deal4_yn,
			unconfirmed_deal5_yn,
			unconfirmed_deal6_yn
	from	enroll_customer
	where	enroll_customer_id = @enroll_customer_id
	
END

