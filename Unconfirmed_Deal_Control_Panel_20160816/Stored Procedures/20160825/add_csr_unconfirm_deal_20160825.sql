USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[add_csr_unconfirm_deal]    Script Date: 08/26/2016 07:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.25
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[add_csr_unconfirm_deal]
@enroll_customer_id	int,
@category_id		int,
@select_yn			bit,
@register_id		int
AS
BEGIN

	SET NOCOUNT ON;
	
	insert into csr_unconfirm_deal
	(
		customer_id,
		category_id,
		select_yn,
		register_id
	)
	values
	(
		@enroll_customer_id,
		@category_id,
		@select_yn,
		@register_id
	)

END

