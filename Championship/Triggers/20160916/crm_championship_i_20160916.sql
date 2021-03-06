USE [CEW]
GO
/****** Object:  Trigger [dbo].[crm_championship_i]    Script Date: 09/16/2016 11:00:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		CHOI
-- Create date: 2016.09.15
-- Description:	
-- Update:		SKC
-- Update date: 2016.09.16
-- Description:	
-- =============================================
ALTER TRIGGER [dbo].[crm_championship_i] ON [dbo].[crm_championship]
FOR INSERT
AS
DECLARE
@championship_id	int,
@championship_days	int,
@date_begin			date
BEGIN

	SET NOCOUNT ON;
	
	select	@championship_id = championship_id,
			@championship_days = championship_days,
			@date_begin = date_begin
	from	inserted
	
	declare @total_round int
	
	select	@total_round = count(round_id)
	from	crm_championship_round_type
	where	sort_seq <= @championship_days
	
	if @total_round > 0
	begin
	
		insert into crm_championship_detail
		(
			championship_id,
			round_id,
			detail_date
		)
		select	@championship_id,
				round_id,
				dateadd(day, @total_round - sort_seq, @date_begin)
		from	crm_championship_round_type
		where	sort_seq <= @championship_days
		order by round_id desc
	
	end
	
END

