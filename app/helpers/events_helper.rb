module EventsHelper
	def all_tags(event)
		event.tags.collect { |t| t.name }.join(", ")
	end

	def event_time(event)
		event.start_date ? "#{event.start_date.hour}:#{event.start_date.min}" : "00:00"
	end
end
