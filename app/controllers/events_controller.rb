class EventsController < ApplicationController
  def index
    @events = Event.limit(20)
  end

  def show
    if params[:id]
      @event = Event.find(params[:id])
    elsif params[:date]
      t = Time.parse params[:date]
      @event = Event.where(held_at: t..(t.to_date.next_day.to_time-1)).first
    end
    @videos = @event.videos
    @game_center = @event.game_center
   end
 end
