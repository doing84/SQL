USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_csr_confirm_status_forYesterday]    Script Date: 08/18/2016 13:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.12
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_csr_confirm_status_forYesterday]
@today_date		date = null
AS
DECLARE
@yesterday_date	date
BEGIN

	SET NOCOUNT ON;
	
	if @today_date is null
	begin
		set @today_date = getdate()
	end
	
	set @yesterday_date = dateadd(day, -1, @today_date)
	
	select	yesterday_date = @yesterday_date,
			total_customer_count = isnull(sum(total_customer_count), 0),
			confirm_count = isnull(sum(confirm_count), 0),
			confirm_rate = isnull(sum(confirm_count), 0) / convert(float, sum(total_customer_count))
	from	(
				select	enroll_customer_id,
						total_customer_count = isnull(count(enroll_customer_id), 0)
				from	enroll_customer 
				where	enroll_customer_status <> 'Z' and
						(register_date = @yesterday_date) and 
						service_type in ('S', 'R')
				group by enroll_customer_id
			) a
			left outer join  
			(
				select	enroll_customer_id,
						confirm_count = isnull(count(enroll_customer_id), 0)
				from	enroll_customer 
				where	enroll_customer_status = 'C' and
						(register_date = @yesterday_date) and
						service_type in ('S', 'R')
				group by enroll_customer_id
			) b on a.enroll_customer_id = b.enroll_customer_id
	
END

