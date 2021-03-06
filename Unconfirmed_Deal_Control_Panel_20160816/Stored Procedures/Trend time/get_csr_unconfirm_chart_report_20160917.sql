USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_csr_unconfirm_trend_time]    Script Date: 08/29/2016 10:55:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.25
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_csr_unconfirm_chart_report]
@time_id	datetime
--@deal1_yn	bit,
--@deal2_yn	bit,
--@deal3_yn	bit,
--@deal4_yn	bit,
--@deal5_yn	bit,
--@deal6_yn	bit
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.*
	from	(
				select	trend_time = (convert(varchar(6),datepart(hour, register_time))),
						unconfirmed_deal1_yn_count = isnull(count(dbo.fget_csr_unconfirm_deal_select_yn(customer_id, 1)), 0),
						unconfirmed_deal2_yn_count = isnull(count(dbo.fget_csr_unconfirm_deal_select_yn(customer_id, 2)), 0),
						unconfirmed_deal3_yn_count = isnull(count(dbo.fget_csr_unconfirm_deal_select_yn(customer_id, 3)), 0),
						unconfirmed_deal4_yn_count = isnull(count(dbo.fget_csr_unconfirm_deal_select_yn(customer_id, 4)), 0),
						unconfirmed_deal5_yn_count = isnull(count(dbo.fget_csr_unconfirm_deal_select_yn(customer_id, 5)), 0),
						unconfirmed_deal6_yn_count = isnull(count(dbo.fget_csr_unconfirm_deal_select_yn(customer_id, 6)), 0)
				from	csr_unconfirm_deal 
				where	select_yn = 1 and
						register_date = @time_id
				group by convert(varchar(6),datepart(hour, register_time))						 
						 
			) a

END

