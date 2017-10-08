class CalendarService

  def initialize(date, user)
    first_date = date.beginning_of_month.beginning_of_week
    second_date = date.end_of_month.end_of_week
    @dates = Hash[(first_date..second_date).to_a.map{ |key| [key] }]
    @events = user.events.by_range(first_date, second_date)
  end

  def create_calendar
    @events.each { |event| eval "add_#{event.frequency}(event)" }
    @dates
  end

  private

  def add_once(event)
    insert(event.start_date.to_date, event)
  end

  def add_dayly(event)
    (start(event)..finish(event)).each { |date| insert(date, event) }
  end

  def add_weekly(event)
    (start(event)..finish(event)).each do |date|
      insert(date, event) if date.wday == event.start_date.wday
    end
  end

  def add_monthly(event)
    @dates.keys.each { |date| insert(date, event) if date.day == event.start_date.day }
  end

  def add_yearly(event)
    @dates.keys.each do |date|
      insert(date, event) if date.month == event.start_date.month && date.day == event.start_date.day
    end
  end

  def start(event)
    start = event.start_date > @dates.keys.first ? event.start_date : @dates.keys.first
    start.to_date
  end

  def finish(event)
    finish = event.finish_date && event.finish_date < @dates.keys.last ? event.finish_date : @dates.keys.last
    finish.to_date
  end

  def insert(date, event)
    @dates[date] ||= []
    @dates[date] << event
  end
end
