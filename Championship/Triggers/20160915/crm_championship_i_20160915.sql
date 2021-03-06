USE [CEW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.15
-- Description:	
-- =============================================
ALTER TRIGGER [dbo].[crm_championship_i] ON [dbo].[crm_championship]
FOR INSERT
AS
DECLARE
@championship_id	int,
@date_begin			date,
@date_end			date,
@round_id			int
BEGIN

	SET NOCOUNT ON;
	
	select	@championship_id = championship_id,
			@date_begin = date_begin,
			@date_end = date_end
	from	crm_championship
		
	select	@round_id = round_id
	from	crm_championship_round_type
	where	sort_seq = 1
		
	insert into crm_championship_detail
	(
		championship_id,
		detail_date,
		round_id
	)
	values	(	
				@championship_id,	
				@date_begin, 
				@round_id
			),
			(	@championship_id,
				(dateadd(day, 1, @date_begin)),
				@round_id 
			),
			(	@championship_id,
				(dateadd(day, 2, @date_begin)),
				@round_id 
			),
			(	@championship_id,
				(dateadd(day, 3, @date_begin)),
				@round_id 
			),
			(	@championship_id,
				(dateadd(day, 4, @date_begin)),
				@round_id 
			),
			(	@championship_id,
				(dateadd(day, 5, @date_begin)),
				@round_id
			),
			(	@championship_id,
				(dateadd(day, 6, @date_begin)),
				@round_id
			),
			(	@championship_id,
				(dateadd(day, 7, @date_begin)),
				@round_id
			)
				
		
END

