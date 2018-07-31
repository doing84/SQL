USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.27
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[rpt_bi_dashboard_rce_summary]
@date_begin		date = null,
@date_end		date = null
AS
DECLARE
@total_rce_e			numeric(9,2) = 0,
@total_rce_deleted_e	numeric(9,2) = 0,
@total_rce_inactive_e	numeric(9,2) = 0,
@total_rce_enrolled_e	numeric(9,2) = 0,
@total_rce_cancelled_e	numeric(9,2) = 0,

@total_rce_a			numeric(9,2) = 0,
@total_rce_deleted_a	numeric(9,2) = 0,
@total_rce_inactive_a	numeric(9,2) = 0,
@total_rce_enrolled_a	numeric(9,2) = 0,
@total_rce_cancelled_a	numeric(9,2) = 0
BEGIN
	
	SET NOCOUNT ON;
			
	select	@total_rce_e = sum(isnull(a.total_est_rce, 0)),
			@total_rce_a = sum(isnull(a.total_rce, 0))
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_site_id = a1.enroll_site_id and			
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	
	select	@total_rce_deleted_e = sum(isnull(a.total_est_rce, 0)),
			@total_rce_deleted_a = sum(isnull(a.total_rce, 0))
	from	enroll_customer_site  a,
			enroll_customer a0,
			enroll_customer_site_contract a1
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_site_id = a1.enroll_site_id and
			a.enroll_site_status = 'C' and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	
	select	@total_rce_inactive_e = sum(isnull(a.total_est_rce, 0)),
			@total_rce_inactive_a = sum(isnull(a.total_rce, 0))
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_site_id = a1.enroll_site_id and
			a0.enroll_customer_status = 'I' and
			a.enroll_site_status = 'I' and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	
	select	@total_rce_enrolled_e = sum(isnull(a.total_est_rce, 0)),
			@total_rce_enrolled_a = sum(isnull(a.total_rce, 0))
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_site_id = a1.enroll_site_id and
			a0.enroll_customer_status in ('X', 'I', 'U', 'C', 'D', 'Z') and
			a.enroll_site_status in ('G', 'X', 'Y') and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)	
			
	select	@total_rce_cancelled_e = sum(isnull(a.total_est_rce, 0)),
			@total_rce_cancelled_a = sum(isnull(a.total_rce, 0))
	from	enroll_customer_site a,
			enroll_customer a0,
			enroll_customer_site_contract a1
	where	a.enroll_customer_id = a0.enroll_customer_id and
			a.enroll_site_id = a1.enroll_site_id and
			a0.enroll_customer_status in ('X', 'I', 'U', 'C', 'D', 'Z') and
			a.enroll_site_status = 'Z' and
			(@date_begin is null or @date_begin <= a1.sign_date) and
			(@date_end is null or a1.sign_date <= @date_end)
	
	select	total_rce_e = isnull(@total_rce_e, 0.0),
			total_rce_deleted_e = isnull(@total_rce_deleted_e, 0),
			total_rce_inactive_e = isnull(@total_rce_inactive_e, 0),
			total_rce_enrolled_e = isnull(@total_rce_enrolled_e, 0),
			total_rce_cancelled_e = isnull(@total_rce_cancelled_e, 0),
						
			total_rce_a = isnull(@total_rce_a, 0.0),
			total_rce_deleted_a = isnull(@total_rce_deleted_a, 0),
			total_rce_inactive_a = isnull(@total_rce_inactive_a, 0),
			total_rce_enrolled_a = isnull(@total_rce_enrolled_a, 0),
			total_rce_cancelled_a = isnull(@total_rce_cancelled_a, 0)
	into	#bi_dashboard_rce_summary
	
	select	a.*,
			net_rce_e = total_processed_e - total_rce_cancelled_e,
			net_rce_a = total_processed_a - total_rce_cancelled_a
	from	(
				select	*,
						total_processed_e = total_rce_e - (total_rce_inactive_e + total_rce_deleted_e),
						total_processed_a = total_rce_a - (total_rce_inactive_a + total_rce_deleted_a)
				from	#bi_dashboard_rce_summary
			) a

END
