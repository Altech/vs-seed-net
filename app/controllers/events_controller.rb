class EventsController < ApplicationController
  def index
    @events = Event.limit(20)
  end

  def show
    @event = Event.find_by_date params[:id]
    @videos = @event.videos
    @game_center = @event.game_center
  end

  before_action :check_logined, only: %i[edit update]

  def edit
    event = Event.find_by_date params[:id]
    if current_player.admin? or current_player.participate?(event)
      @participants = event.players
      @event = event
    else
      redirect_to event_path
    end
  end

  def update
    if current_player.admin? or current_player.participate?(event)
      event = Event.find_by_date params[:id]
      participants = event.players
      mails = params[:mail].split(/\s*,\s*/)
      mails.each do |mail|
        next if participants.map(&:mail).include? mail
        player = Player.find_by_mail(mail)
        EventParticipant.create!(event_id: event.id, player_id: player.id) if player
      end
      redirect_to edit_event_path(event)
    else
      redirect_to event_path
    end
  end
end
