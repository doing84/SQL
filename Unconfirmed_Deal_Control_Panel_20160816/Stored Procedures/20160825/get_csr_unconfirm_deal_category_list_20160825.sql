USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_csr_unconfirm_deal_category_list]    Script Date: 08/26/2016 07:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.18
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_csr_unconfirm_deal_category_list]
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.*,
			b.full_name
	from	csr_unconfirm_deal_category a, 
			[login] b
	where	a.register_id = b.login_id	
	
END

