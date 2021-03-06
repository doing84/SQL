USE [CEW]
GO
/****** Object:  Trigger [dbo].[crm_championship_seed_u]    Script Date: 09/15/2016 07:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SKC
-- Create date: 2016.09.13
-- Description:	
-- =============================================
ALTER TRIGGER [dbo].[crm_championship_seed_u] ON [dbo].[crm_championship_seed]
FOR UPDATE
AS
IF	UPDATE(login_id)
BEGIN

	SET NOCOUNT ON;
	
	if exists
	(
		select	1
		from	inserted a,
				deleted b
		where	a.seed_id = b.seed_id and
				isnull(a.login_id, 0) = isnull(b.login_id, 0)
	) return

	insert into crm_championship_seed_history
	(
		seed_id,
		login_id
	)
	select	seed_id,
			login_id
	from	inserted

END
