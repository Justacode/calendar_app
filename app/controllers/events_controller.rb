class EventsController < ApplicationController
  include CalendarHelper
  include EventsHelper

  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = current_user.events
    @date = params[:date] ? params[:date].to_date: Date.current

    @calendar = create_calendar

    @day_events = day_events
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
    @event.finish_date = @event.start_date if @event.frequency == "once"

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
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :frequency, :user_id, :start_date, :finish_date)
  end
end
