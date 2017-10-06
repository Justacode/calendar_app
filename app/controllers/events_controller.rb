class EventsController < ApplicationController
  include EventsHelper

  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @date = params[:date] ? params[:date].to_date: Date.current
    @events = set_events

    unless params[:tag] || params[:all]
      @calendar = CalendarService.new(@date).create_calendar
      @events = day_events
    end
  end

  def show
  end

  def new
    @event = current_user.events.build
  end

  def edit
  end

  def create
    @event = current_user.events.new(event_params)

    @event.start_date = set_date_with_time
    @event.finish_date = set_finish_date

    if @event.save
      flash[:success] = "Event successfully created"
      redirect_to events_path
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_events
    if params[:all]
      current_user.events
    elsif params[:tag]
      Event.by_tag_name(params[:tag])
    end
  end

  def set_date_with_time
    time = params[:time].to_s.split(":")
    @event.start_date.change(hour: time.first, min: time.last)
  end

  def set_finish_date
    if @event.frequency == "once"
      @event.start_date
    elsif params[:forever]
      nil
    else
      @event.finish_date
    end
  end

  def event_params
    params.require(:event).permit(:name, :description, :frequency, :user_id, :start_date, :finish_date, :tags)
  end
end
