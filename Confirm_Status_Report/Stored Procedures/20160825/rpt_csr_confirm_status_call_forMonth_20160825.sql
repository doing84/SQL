USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_csr_confirm_status_call_forMonth]    Script Date: 08/25/2016 20:12:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.12
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_csr_confirm_status_call_forMonth]
@today_date			date = null
AS
DECLARE
@prev_month_begin	date,
@prev_month_end		date
BEGIN

	SET NOCOUNT ON;
	
	if @today_date is null
	begin
		set @today_date = getdate()
	end
	
	set @prev_month_begin = dateadd(month, -1, @today_date)
	set @prev_month_end	= dateadd(day, -1, @today_date)
	
	select	date_start = @prev_month_begin,
			date_end = @prev_month_end,
			csr_calls_count = isnull(sum(csr_calls_count), 0),
			confirm_count = isnull(sum(confirm_count), 0),
			confirm_rate = isnull(sum(confirm_count), 0) / convert(float, sum(csr_calls_count))
	from	(
				select	a.enroll_customer_id,
						csr_calls_count = isnull(count(a.call_id), 0)
				from	csr_call a,
						enroll_customer b
				where	a.enroll_customer_id = b.enroll_customer_id and
						(a.register_date between @prev_month_begin and @prev_month_end) and
						service_type in ('S', 'R')			
				group by  a.enroll_customer_id
			) a
			left outer join  
			(
				select	enroll_customer_id,
						confirm_count = isnull(count(enroll_customer_id), 0)
				from	enroll_customer 
				where	(enroll_customer_status = 'C') and
						(register_date between @prev_month_begin and @prev_month_end) and
						service_type in ('S', 'R')
				group by enroll_customer_id
			) b on a.enroll_customer_id = b.enroll_customer_id
			
END

