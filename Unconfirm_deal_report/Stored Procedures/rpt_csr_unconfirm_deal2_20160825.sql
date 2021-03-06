USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[rpt_csr_unconfirm_deal2]    Script Date: 08/25/2016 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.08.17
-- Description:

-- Author:		CHOI
-- Update date: 2016.08.18
-- Description:		
-- =============================================
ALTER PROCEDURE [dbo].[rpt_csr_unconfirm_deal2]
@agent_id			int = null,
@agent_type			char(1) = null,
@emp_type			char(1) = null
AS
BEGIN

	SET NOCOUNT ON;
	
	select	login_id,
			name= full_name
	into	#login_ids
	from	[login]
	where	login_status = 'A' and
			(@agent_id is null or login_id = @agent_id) and
			(@agent_type is null or [login_type] = @agent_type) and
			(@emp_type is null or emp_type = @emp_type)
	
	select	*,
			total_customer_count = nullif(dbo.fget_agent_total_customer_count(login_id), 0),
			total_customer_rce = nullif(dbo.fget_agent_total_customer_rce(login_id), 0),
			deleted_customer_count = nullif(dbo.fget_agent_deleted_customer_count(login_id), 0),
			deleted_customer_rce = nullif(dbo.fget_agent_deleted_customer_rce(login_id), 0),
			confirm_count_sv = nullif(dbo.fget_agent_confirm_count_sv(login_id), 0),
			confirm_count_lv = nullif(dbo.fget_agent_confirm_count_lv(login_id), 0),
			confirm_rce = nullif(dbo.fget_agent_confirm_rce(login_id), 0),
			non_confirm_count = nullif(dbo.fget_agent_non_confirm_count(login_id), 0),
			non_confirm_rce = nullif(dbo.fget_agent_non_confirm_rce(login_id), 0)
	
	into	#rpt_csr_unconfirm
	from	#login_ids
	
	select	a.*
	from	(		
				select	*,
						total_customer_rate = total_customer_count / convert(float, total_customer_count),
						confirm_sv_rate = confirm_count_sv / convert(float, total_customer_count),
						confirm_lv_rate = confirm_count_lv / convert(float, total_customer_count),
						deleted_customer_rate = deleted_customer_count / convert(float, total_customer_count),
						non_confirm_rate = non_confirm_count / convert(float, total_customer_count),
						confirm_rce_rate = confirm_rce / convert(float, total_customer_rce),
						deleted_rce_rate = deleted_customer_rce / convert(float, total_customer_rce),
						non_confirm_rce_rate = non_confirm_rce / convert(float, total_customer_rce)
				from	#rpt_csr_unconfirm 
			) a 
			inner join [login] b on a.login_id = b.login_id
			
END