USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[add_crm_quota_rate]    Script Date: 07/11/2016 07:35:25 ******/
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
ALTER PROCEDURE [dbo].[add_crm_quota_rate]
@quota_desc			varchar(100) = null,
@value_begin		numeric(9,2),
@value_end			numeric(9,2),
@template_file		varchar(50) = null,
@probation_file		varchar(50) = null,
@register_id		int
AS
DECLARE
@quota_id			int
BEGIN

	SET NOCOUNT ON;
	
	insert into crm_quota_rate
	(	
		quota_desc,
		value_begin,
		value_end,
		probation_file,		
		template_file,
		register_id
	)
	values
	(	
		@quota_desc,
		@value_begin,
		@value_end,
		@probation_file,		
		@template_file,
		@register_id		
	)
	SET @quota_id = SCOPE_IDENTITY();
	
	select	*
	from	crm_quota_rate
	where	quota_id = @quota_id
	
END

