USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.08.25
-- Description:	
-- =============================================
CREATE PROCEDURE addupd_csr_unconfirm_deal
@enroll_customer_id	int,
@category_id		int,
@select_yn			bit,
@register_id		int
AS
BEGIN

	SET NOCOUNT ON;
	
	if exists
	(
		select	1
		from	csr_unconfirm_deal
		where	customer_id = @enroll_customer_id and
				category_id = @category_id
	)
	begin
	
		update	csr_unconfirm_deal
		set		select_yn = @select_yn,	
				update_id = @register_id,	
				update_date = getdate()	
		where	customer_id = @enroll_customer_id and
				category_id = @category_id
	
	end
	else
	begin
	
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
	
	end

END

