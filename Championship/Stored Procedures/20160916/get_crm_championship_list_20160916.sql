USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_crm_championship_list]    Script Date: 09/16/2016 08:52:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.13
-- Description:	
-- Update:		SKC
-- Update date: 2016.09.16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[get_crm_championship_list]
@login_id				int = null,
@championship_status	char(1) = null,
--@date_count				int = null,
@date_begin				date = null,
@date_end				date = null
AS
BEGIN

	SET NOCOUNT ON
	
	select	a.*,
			championship_status_desc = a1.status_desc,
			b.date_count,
			login_desc = dbo.fget_crm_championship_login_desc(a.championship_id, @login_id)
	from	crm_championship a
			inner join crm_championship_status a1 on a.championship_status = a1.status_code
			inner join
			(
				select	a.championship_id,
						date_count = count(b.detail_id)
				from	crm_championship a,
						crm_championship_detail b
				where	a.championship_id = b.championship_id and
						b.date_yn = 1
				group by a.championship_id
			) b	on a.championship_id = b.championship_id
	where	(@championship_status is null or a.championship_status = @championship_status) and
			(@date_begin is null or @date_begin <= a.date_begin and
			@date_end is null or a.date_end <= @date_end) 

END

