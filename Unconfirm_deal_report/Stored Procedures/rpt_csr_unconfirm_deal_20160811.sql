USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_csr_unconfirm_deal]    Script Date: 08/12/2016 13:04:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.11
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[rpt_csr_unconfirm_deal]
@agent_id			int = null,
@agent_type			char(1) = null,
@emp_type			char(1) = null
AS
--DECLARE
--@today_date			date = null,
--@yesterday_date		date = null
BEGIN

	SET NOCOUNT ON;
	
	--set @today_date = getdate()
	--set @yesterday_date = dateadd(day, -1, @today_date)	
	
	select	a.total_customer_count,
			a1.total_customer_rce,
			b.deleted_customer_count,
			b1.deleted_customer_rce,
			c.confirm_count,
			c1.confirm_rce,
			d.non_confirm_count,
			d1.non_confirm_rce,
			g.full_name,
			g.login_id
			--e.today_total_call_count,
			--e1.today_total_confirm_count,
			--f.yesterday_total_call_count,
			--f1.yesterday_total_confirm_count
			
	from	(
				select	total_customer_count = isnull(count(a.enroll_customer_id), 0),
						b.login_id
				from	enroll_customer a
						left outer join [login] b on a.agent_id = b.login_id
				where	a.enroll_customer_status <> 'Z' and
						b.login_status = 'A' and
						(@agent_id is null or b.login_id = @agent_id) and
						(@agent_type is null or b.[login_type] = @agent_type) and
						(@emp_type is null or b.emp_type = @emp_type)
				group by b.login_id
			) a
			left outer join  
			(
				select	total_customer_rce = isnull(sum(b.total_est_rce), 0),
						c.login_id
				from	enroll_customer a
						inner join enroll_customer_site b on a.enroll_customer_id = b.enroll_customer_id
						left outer join [login] c on a.agent_id = c.login_id
				where	a.enroll_customer_status <> 'Z' and
						c.login_status = 'A' and
						(@agent_id is null or c.login_id = @agent_id) and
						(@agent_type is null or c.[login_type] = @agent_type) and
						(@emp_type is null or c.emp_type = @emp_type)
				group by c.login_id
			) a1 on a.login_id = a1.login_id
			left outer join 
			(
				select	deleted_customer_count = isnull(count(a.enroll_customer_id), 0),
						b.login_id
				from	enroll_customer a
						left outer join [login] b on a.agent_id = b.login_id
				where	a.enroll_customer_status = 'Z' and
						b.login_status = 'A' and
						(@agent_id is null or b.login_id = @agent_id) and
						(@agent_type is null or b.[login_type] = @agent_type) and
						(@emp_type is null or b.emp_type = @emp_type)
				group by b.login_id
			) b  on a.login_id = b.login_id
			left outer join 
			(
				select	deleted_customer_rce = isnull(sum(b.total_est_rce), 0),
						c.login_id
				from	enroll_customer a
						inner join enroll_customer_site b on a.enroll_customer_id = b.enroll_customer_id
						left outer join [login] c on a.agent_id = c.login_id
				where	a.enroll_customer_status = 'Z' and
						c.login_status = 'A' and
						(@agent_id is null or c.login_id = @agent_id) and
						(@agent_type is null or c.[login_type] = @agent_type) and
						(@emp_type is null or c.emp_type = @emp_type)
				group by c.login_id
			) b1 on b.login_id = b1.login_id
			left outer join 
			(
				select	confirm_count = isnull(count(a.enroll_customer_id), 0),
						b.login_id
				from	enroll_customer a
						left outer join [login] b on a.agent_id = b.login_id
				where	a.enroll_customer_status in ('C', 'D') and
						b.login_status = 'A' and
						(@agent_id is null or b.login_id = @agent_id) and
						(@agent_type is null or b.[login_type] = @agent_type) and
						(@emp_type is null or b.emp_type = @emp_type)
				group by b.login_id
			) c on b.login_id = c.login_id
			left outer join 
			(
				select	confirm_rce = isnull(sum(b.total_est_rce), 0),
						c.login_id
				from	enroll_customer a
						inner join enroll_customer_site b on a.enroll_customer_id = b.enroll_customer_id
						left outer join [login] c on a.agent_id = c.login_id
				where	a.enroll_customer_status in ('C', 'D') and
						c.login_status = 'A' and
						(@agent_id is null or c.login_id = @agent_id) and
						(@agent_type is null or c.[login_type] = @agent_type) and
						(@emp_type is null or c.emp_type = @emp_type)
				group by c.login_id
			) c1 on c.login_id = c1.login_id
			left outer join 
			(
				select	non_confirm_count = isnull(count(a.enroll_customer_id), 0),
						b.login_id
				from	enroll_customer a
						left outer join [login] b on a.agent_id = b.login_id
				where	(a.enroll_customer_status = 'N' or 
						a.enroll_customer_status not in ('X', 'I', 'U', 'C', 'D', 'Z')) and
						b.login_status = 'A' and
						(@agent_id is null or b.login_id = @agent_id) and
						(@agent_type is null or b.[login_type] = @agent_type) and
						(@emp_type is null or b.emp_type = @emp_type)
				group by b.login_id
			) d on c.login_id = d.login_id
			left outer join 
			(
				select	non_confirm_rce = isnull(sum(b.total_est_rce), 0),
						c.login_id
				from	enroll_customer a
						inner join enroll_customer_site b on a.enroll_customer_id = b.enroll_customer_id
						left outer join [login] c on a.agent_id = c.login_id
				where	(a.enroll_customer_status = 'N' or 
						a.enroll_customer_status not in ('X', 'I', 'U', 'C', 'D', 'Z')) and
						c.login_status = 'A' and
						(@agent_id is null or c.login_id = @agent_id) and
						(@agent_type is null or c.[login_type] = @agent_type) and
						(@emp_type is null or c.emp_type = @emp_type)
				group by c.login_id
			) d1 on d.login_id = d1.login_id
			inner join
			[login] g on d.login_id = g.login_id
			--left outer join
			--(
			--	select	a.agent_id,
			--			today_total_call_count = isnull(count(b.call_id), 0)
			--	from	enroll_customer a,
			--			csr_call b,
			--			[login] c  
			--	where	a.enroll_customer_id = b.enroll_customer_id and
			--			a.login_id = c.login_id and
			--			c.login_status = 'A' and
			--			(@agent_id is null or a.agent_id = @agent_id) and
			--			(@agent_type is null or c.[login_type] = @agent_type) and
			--			(@emp_type is null or c.emp_type = @emp_type) and
			--			(@today_date is null or b.register_date = @today_date)
			--	group by a.agent_id
			--) e on d.agent_id = e.agent_id
			--left outer join
			--(
			--	select	a.agent_id,
			--			today_total_confirm_count = isnull(count(a.enroll_customer_id), 0)
			--	from	enroll_customer a,
			--			csr_call b,
			--			[login] c
			--	where	a.enroll_customer_id = b.enroll_customer_id and
			--			a.login_id = c.login_id and
			--			a.enroll_customer_status in ('C', 'D') and
			--			c.login_status = 'A' and
			--			(@agent_id is null or a.agent_id = @agent_id) and
			--			(@agent_type is null or c.[login_type] = @agent_type) and
			--			(@emp_type is null or c.emp_type = @emp_type) and
			--			(@today_date is null or b.register_date = @today_date)
			--	group by a.agent_id
			--) e1 on e.agent_id = e1.agent_id
			--left outer join
			--(
			--	select	a.agent_id,
			--			yesterday_total_call_count = isnull(count(b.call_id), 0)
			--	from	enroll_customer a,
			--			csr_call b,
			--			[login] c  
			--	where	a.enroll_customer_id = b.enroll_customer_id and
			--			a.login_id = c.login_id and
			--			c.login_status = 'A' and
			--			(@agent_id is null or a.agent_id = @agent_id) and
			--			(@agent_type is null or c.[login_type] = @agent_type) and
			--			(@emp_type is null or c.emp_type = @emp_type) and
			--			(@yesterday_date is null or b.register_date = @yesterday_date)
			--	group by a.agent_id
			--) f on e.agent_id = f.agent_id
			--left outer join
			--(
			--	select	a.agent_id,
			--			yesterday_total_confirm_count = isnull(count(a.enroll_customer_id), 0)
			--	from	enroll_customer a,
			--			csr_call b,
			--			[login] c
			--	where	a.enroll_customer_id = b.enroll_customer_id and
			--			a.login_id = c.login_id and
			--			a.enroll_customer_status in ('C', 'D') and
			--			c.login_status = 'A' and
			--			(@agent_id is null or a.agent_id = @agent_id) and
			--			(@agent_type is null or c.[login_type] = @agent_type) and
			--			(@emp_type is null or c.emp_type = @emp_type) and
			--			(@yesterday_date is null or b.register_date = @yesterday_date)
			--	group by a.agent_id
			--) f1 on f.agent_id = f1.agent_id
			
	END

