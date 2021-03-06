USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[del_crm_championship_seed]    Script Date: 09/21/2016 08:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.09.19
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[del_crm_championship_seed]
@seed_id	int
AS
BEGIN

	SET NOCOUNT ON;
	
	if exists
	(
		select	1
		from	crm_championship_seed a,
				crm_championship_detail b
		where	a.detail_id = b.detail_id and
				b.detail_status <> 'I' and
				a.seed_id = @seed_id
	)
	begin
		raiserror('Invalid Request!', 16, 1)
		return -1
	end
	
	delete
	from	crm_championship_seed
	where	seed_id = @seed_id
	
END

