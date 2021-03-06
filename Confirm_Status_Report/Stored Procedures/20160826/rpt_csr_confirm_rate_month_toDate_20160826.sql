USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_csr_confirm_rate_month_toDate]    Script Date: 08/26/2016 18:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.12
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_csr_confirm_rate_month_toDate]
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
			rate_24 = rate_24 / convert(float, total),
			rate_48 = rate_48 / convert(float, total),
			rate_72 = rate_72 / convert(float, total),
			rate_over_72 = rate_over_72 / convert(float, total)
	from	(
				select	total = isnull(sum(rate_24), 0) + isnull(sum(rate_48), 0) + isnull(sum(rate_72), 0) + isnull(sum(rate_over_72), 0),
						rate_24 = isnull(sum(rate_24), 0),
						rate_48 = isnull(sum(rate_48), 0),
						rate_72 = isnull(sum(rate_72), 0),
						rate_over_72 = isnull(sum(rate_over_72), 0)
				from	(
							select	enroll_customer_id
							from	enroll_customer 
							where	enroll_customer_status = 'C' and
									service_type in ('S', 'R') and
									(register_date between @prev_month_begin and @prev_month_end) 
							group by enroll_customer_id
						) a
						left outer join
						(
							select	enroll_customer_id,
									rate_24 = isnull(count(enroll_customer_id), 0)
							from	enroll_customer 
							where	enroll_customer_status = 'C' and
									service_type in ('S', 'R') and
									(register_date between @prev_month_begin and @prev_month_end) and
									(datediff(hour, register_date, confirmed_customer_date) <= 24)
							group by enroll_customer_id
						) b on a.enroll_customer_id = b.enroll_customer_id
						left outer join
						(
							select	enroll_customer_id,
									rate_48 = isnull(count(enroll_customer_id), 0)
							from	enroll_customer 
							where	enroll_customer_status = 'C' and
									service_type in ('S', 'R') and
									(register_date between @prev_month_begin and @prev_month_end) and
									(datediff(hour, register_date, confirmed_customer_date) > 24 and
									datediff(hour, register_date, confirmed_customer_date) <= 48)
							group by enroll_customer_id
						) c on a.enroll_customer_id = c.enroll_customer_id
						left outer join 
						(
							select	enroll_customer_id,
									rate_72 = isnull(count(enroll_customer_id), 0)
							from	enroll_customer 
							where	enroll_customer_status = 'C' and
									service_type in ('S', 'R') and
									(register_date between @prev_month_begin and @prev_month_end) and
									(datediff(hour, register_date, confirmed_customer_date) > 48 and
									datediff(hour, register_date, confirmed_customer_date) <= 72)
							group by enroll_customer_id
						) d on a.enroll_customer_id = d.enroll_customer_id
						left outer join 
						(
							select	enroll_customer_id,
									rate_over_72 = isnull(count(enroll_customer_id), 0)
							from	enroll_customer 
							where	enroll_customer_status = 'C' and
									service_type in ('S', 'R') and
									(register_date between @prev_month_begin and @prev_month_end) and
									(datediff(hour, register_date, confirmed_customer_date) > 72)
							group by enroll_customer_id
						) e on a.enroll_customer_id = e.enroll_customer_id
			) a
				
END

