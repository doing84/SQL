USE [CEW]
GO
/****** Object:  Trigger [dbo].[contact_log_d]    Script Date: 07/26/2016 15:50:00 ******/
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
ALTER TRIGGER [dbo].[contact_log_d] ON [dbo].[contact_log]
FOR DELETE
AS
BEGIN

	SET NOCOUNT ON;
	
	update	contact
	set		log_count = a.log_count - 1
	from	contact a,
			deleted b
	where	a.contact_id = b.contact_id
			
END
