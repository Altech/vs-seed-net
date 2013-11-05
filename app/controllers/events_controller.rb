class EventsController < ApplicationController
  def index
    @events = Event.limit(20)
  end

  def show
    @event = Event.find(params[:id])
    @videos = @event.videos
    @game_center = @event.game_center
  end
end