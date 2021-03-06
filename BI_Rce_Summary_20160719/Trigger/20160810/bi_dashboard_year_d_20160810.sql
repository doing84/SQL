USE [CEW]
GO
/****** Object:  Trigger [dbo].[bi_dashboard_year_d]    Script Date: 08/10/2016 11:47:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SKC
-- Create date: 2016.08.05
-- Description:	
-- =============================================
ALTER TRIGGER [dbo].[bi_dashboard_year_d] ON [dbo].[bi_dashboard_year]
FOR DELETE
AS
DECLARE
@year_id	int
BEGIN

	SET NOCOUNT ON;
	
	select	@year_id = year_id
	from	deleted
	
	delete
	from	bi_dashboard_week_summary
	where	year_id = @year_id
	
END
