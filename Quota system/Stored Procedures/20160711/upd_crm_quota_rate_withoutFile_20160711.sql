USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[upd_crm_quota_rate_withoutFile]    Script Date: 07/11/2016 07:42:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Update date: 2016.07.11
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[upd_crm_quota_rate_withoutFile]
@quota_id			int,
@quota_desc			varchar(100),
@value_begin		numeric(9,2),
@value_end			numeric(9,2),
@register_id		int
AS
BEGIN

	SET NOCOUNT ON;
		
	update	crm_quota_rate
	set		quota_desc = @quota_desc,
			value_begin = @value_begin,
			value_end = @value_end,
			update_id = @register_id,
			update_date = getdate()
	where	quota_id = @quota_id
		
END

