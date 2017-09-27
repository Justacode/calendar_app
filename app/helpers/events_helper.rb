module EventsHelper
	def day_events
		date = params[:day] ? params[:day].to_date : @date
		@calendar[@date] unless @date == params[:date]
	end
end
