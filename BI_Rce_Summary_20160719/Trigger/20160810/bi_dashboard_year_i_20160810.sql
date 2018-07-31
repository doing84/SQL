USE [CEW]
GO
/****** Object:  Trigger [dbo].[bi_dashboard_year_i]    Script Date: 08/10/2016 11:47:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.08.05
-- Description:	
-- =============================================
ALTER TRIGGER [dbo].[bi_dashboard_year_i] ON [dbo].[bi_dashboard_year]
FOR INSERT
AS
DECLARE
@year_id	int
BEGIN

	SET NOCOUNT ON;
	
	select	@year_id = year_id
	from	inserted
	
	insert into bi_dashboard_week_summary
	(
		year_id,
		week_id
	)
	select	@year_id,
			week_id
	from	calendar_week
	
			
END

