module CalendarHelper

  def create_calendar
    first_date = @date.beginning_of_month.beginning_of_week
    second_date = @date.end_of_month.end_of_week
    dates = Hash[(first_date..second_date).to_a.map{ |key| [key] }]

    events = Event.by_range(first_date, second_date)
    p events
    construct_calendar(dates, events)
  end

  def construct_calendar(dates, events)
    events.each {|event| eval "add_#{event.frequency}(event, dates)"}
    dates
  end

  def add_once(event, dates)
    insert dates, event.start_date.to_date, event
  end

  def add_dayly(event, dates)
    (start(event, dates)..finish(event, dates)).each { |d| insert(dates, d, event) }
  end

  def add_weekly(event, dates)
    (start(event, dates)..finish(event, dates)).each do |d|
      insert(dates, d, event) if d.wday == event.start_date.wday 
    end
  end

  def add_monthly(event, dates)
    dates.keys.each { |d| insert(dates, d, event) if d.day == event.start_date.day }
  end

  def add_yearly(event, dates)
    month = @date.month
    if ((month -1)..(month + 1)).include? event.start_date.month
      dates.keys.each do |d|
        if d.month == event.start_date.month && d.day == event.start_date.day
          insert(dates, d, event)
        end
      end
    end
  end

  def start(event, dates)
    start = event.start_date > dates.keys.first ? event.start_date : dates.keys.first
    start.to_date
  end

  def finish(event, dates)
    finish = event.finish_date && event.finish_date < dates.keys.last ? event.finish_date : dates.keys.last
    finish.to_date
  end

  def insert(dates, date, event)
    dates[date] ||= []
    dates[date] << event
  end
end
