USE [CEW]
GO
/****** Object:  Trigger [dbo].[crm_championship_detail_u]    Script Date: 09/21/2016 08:56:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SKC
-- Create date: 2016.09.16
-- Description:	
-- =============================================
ALTER TRIGGER [dbo].[crm_championship_detail_u] ON [dbo].[crm_championship_detail]
FOR UPDATE
AS
IF	UPDATE(date_yn)
BEGIN

	SET NOCOUNT ON;
	
	if exists
	(
		select	1
		from	inserted a,
				deleted b
		where	a.detail_id = b.detail_id and
				a.date_yn = b.date_yn
	) return
	
	declare @championship_id	int
	declare @date_yn			bit
		
	select	@championship_id = championship_id,
			@date_yn = date_yn
	from	inserted
	
	declare @detail_date	date
	declare @detail_count	int
	declare @total_round	int
	
	select	@detail_date = min(b.detail_date),
			@detail_count = count(b.detail_id)
	from	crm_championship a,
			crm_championship_detail b
	where	a.championship_id = b.championship_id and
			a.championship_id = @championship_id and
			b.date_yn = 1
			
	select	@total_round = count(round_id)
	from	crm_championship_round_type
	where	sort_seq <= @detail_count
	
	if @detail_count > 0 and @total_round > 0
	begin
	
		update	crm_championship_detail
		set		round_id = null,
				update_date = getdate()
		where	championship_id = @championship_id
		
		declare @detail_id	int
		declare @round_id	int
		declare @round_date	date
		
		declare curRounds cursor for
		select	detail_id =
				(
					select	min(detail_id)
					from	crm_championship_detail
					where	championship_id = @championship_id and
							round_id is null and
							date_yn = 1
				),
				round_id,
				dateadd(day, @total_round - sort_seq, @detail_date)
		from	crm_championship_round_type
		where	sort_seq <= @detail_count
		order by round_id desc
			
		open curRounds

		fetch next from curRounds
		into	@detail_id,
				@round_id,
				@round_date
			
		while @@fetch_status = 0
		begin
		
			update	crm_championship_detail
			set		round_id = @round_id,
					detail_date = @round_date,
					update_date = getdate()
			where	detail_id = @detail_id

			fetch next from curRounds
			into	@detail_id,
					@round_id,
					@round_date

		end

		close curRounds
		deallocate curRounds
	
	end
	
END

