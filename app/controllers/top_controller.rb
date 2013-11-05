class TopController < ApplicationController
  def index
    # pick up latest event
    @event = Event.order('held_at DESC').to_a[2] # first
    @videos = @event.videos
    @game_center = @event.game_center
  end
end
