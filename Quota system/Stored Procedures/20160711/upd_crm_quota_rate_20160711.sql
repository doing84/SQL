USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[upd_crm_quota_rate]    Script Date: 07/11/2016 07:42:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.08
-- Description:	
--
-- Update:		SKC
-- Update date: 2016.07.11
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[upd_crm_quota_rate]
@quota_id			int,
@quota_desc			varchar(100),
@value_begin		numeric(9,2),
@value_end			numeric(9,2),
@template_file		varchar(50) = null,
@probation_file		varchar(50) = null,
@register_id		int
AS
BEGIN

	SET NOCOUNT ON;
		
	update	crm_quota_rate
	set		quota_desc = @quota_desc,
			value_begin = @value_begin,
			value_end = @value_end,
			template_file = @template_file,
			probation_file = @probation_file,		
			update_id = @register_id,
			update_date = getdate()
	where	quota_id = @quota_id
		
END

