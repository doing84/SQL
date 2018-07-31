USE [CEW]
GO
/****** Object:  UserDefinedFunction [dbo].[fget_edi_site_upload_transaction_code_count]    Script Date: 06/20/2016 22:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2015.06.20
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[fget_enroll_customer_site_contract_commission_count]
(
	@enroll_site_id			int
)
RETURNS int
AS
BEGIN

	DECLARE	@ResultVar	int = 0
	
	select	@ResultVar = count(distinct(a.enroll_contract_id))
	from	enroll_customer_site_contract_commission a
			inner join enroll_customer_site_contract b on a.enroll_contract_id = b.enroll_contract_id
	where	b.enroll_site_id = @enroll_site_id 
			
	
	RETURN	@ResultVar
	
END


