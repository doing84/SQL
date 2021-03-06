USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_csr_unconfirm_trend_time]    Script Date: 08/26/2016 07:55:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.25
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_csr_unconfirm_trend_time]
@time_id	datetime
AS
BEGIN

	SET NOCOUNT ON;
	
	select	a.*
	from	(
				select	time = convert(varchar(6),datepart(hour, a.register_datetime)),
						call_count = isnull(count(a.call_id), 0.00)
				from	csr_call a
						left outer join enroll_customer b on a.enroll_customer_id = b.enroll_customer_id
				where	a.register_date = @time_id and
						b.enroll_customer_status = 'N' or 
                        b.enroll_customer_status not in ('X', 'I', 'U', 'C', 'D', 'Z')
				group by convert(varchar(6),datepart(hour, a.register_datetime))
			) a

END

--select a.enroll_customer_id,
--		a.call_id,
--		a.register_date,
--		a.register_datetime,
--		call_category_id						
--from	csr_call a,
--		enroll_customer b 
--where	a.enroll_customer_id = b.enroll_customer_id and
--		b.enroll_customer_status = 'N' or 
--		b.enroll_customer_status not in ('X', 'I', 'U', 'C', 'D', 'Z')