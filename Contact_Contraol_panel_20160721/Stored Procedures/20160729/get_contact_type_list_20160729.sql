USE [CEW]
GO
/****** Object:  StoredProcedure [dbo].[get_contact_type_list]    Script Date: 07/29/2016 09:49:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.07.26
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[get_contact_type_list]
AS
BEGIN

	select *
	from contact_type
	
END

