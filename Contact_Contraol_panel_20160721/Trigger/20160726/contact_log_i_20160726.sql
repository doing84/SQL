USE [CEW]
GO
/****** Object:  Trigger [dbo].[contact_log_i]    Script Date: 07/26/2016 15:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.22
-- Description:	
-- Author:		SKC
-- Create date: 2016.07.26
-- Description:	
-- =============================================
ALTER TRIGGER [dbo].[contact_log_i] ON [dbo].[contact_log]
FOR INSERT
AS
BEGIN

	SET NOCOUNT ON;
	
	update	contact
	set		log_count = a.log_count + 1
	from	contact a,
			inserted b
	where	a.contact_id = b.contact_id
			
END
