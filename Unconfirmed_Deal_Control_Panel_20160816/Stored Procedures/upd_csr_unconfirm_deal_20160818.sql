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
CREATE PROCEDURE [dbo].[upd_csr_unconfirm_deal]
@enroll_customer_id		int,
@unconfirmed_deal1_yn	bit,
@unconfirmed_deal2_yn	bit,
@unconfirmed_deal3_yn	bit,
@unconfirmed_deal4_yn	bit,
@unconfirmed_deal5_yn	bit,
@unconfirmed_deal6_yn	bit
AS
BEGIN

	SET NOCOUNT ON;
	
	update	enroll_customer
	set		unconfirmed_deal1_yn = @unconfirmed_deal1_yn, 	
			unconfirmed_deal2_yn = @unconfirmed_deal2_yn,	
			unconfirmed_deal3_yn = @unconfirmed_deal3_yn,	
			unconfirmed_deal4_yn = @unconfirmed_deal4_yn,	
			unconfirmed_deal5_yn = @unconfirmed_deal5_yn,	
			unconfirmed_deal6_yn = @unconfirmed_deal6_yn	
	where	enroll_customer_id = @enroll_customer_id
	
END

