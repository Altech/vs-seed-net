class TopController < ApplicationController
  def index
    # pick up latest event
    @event = Event.first
    @videos = @event.videos
    @game_center = @event.game_center
  end
end
