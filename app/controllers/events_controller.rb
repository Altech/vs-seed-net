# -*- coding: utf-8 -*-
class EventsController < ApplicationController
  def index
    @events = Event.limit(20)
    render layout: false if request.headers['X-PJAX']
  end

  def show
    @event = Event.find_by_date params[:id]
    if params[:filtering_id].to_i == 0
      @games = @event.games
    elsif params[:filtering_id].to_i == -1
      @games = @event.games.select{|game| game.include_unknown_player?}
      @games = Kaminari.paginate_array(@games)
    else
      @games = @event.games.select{|game| game.include_player?(params[:filtering_id].to_i)}
      @games = Kaminari.paginate_array(@games)
    end
    @game_center = @event.game_center
    if (Rails.root + "app/views/events/custom/show_#{@event.held_at.strftime("%Y%m%d")}.html.slim").exist?
      render file: "events/custom/show_#{@event.held_at.strftime("%Y%m%d")}", layout: !(ajax?||request.headers['X-PJAX'])
    else
      render layout: !(ajax?||request.headers['X-PJAX'])
    end
  end

  def edit
    @event = Event.find_by_date params[:id]
    @games = @event.games
    @game_center = @event.game_center
    @players = Player.all.select{|player| !player.participate?(@event)}
    @participants = @event.players
  end

  def update
    event = Event.find_by_date params[:id]

    if params[:player]
      params[:player].each do |player_id, boolean|
        if boolean == 'true'
          EventParticipant.create!(event_id: event.id, player_id: player_id)
        end
      end
    elsif params[:video]
      videos = Hash[params['video'].to_a.map{|k,v| [k.to_i,v]}.sort_by(&:first)]

      videos.each do |video_id, data|
        player_id = data['player_id']
        mecha_id = MechaName.where(name: data['mecha_id']).first.mecha_id unless data['mecha_id'].nil? or data['mecha_id'].empty?
        video = Video.find(video_id)
        update_attribute_of_continuous_videos_in_bulk(video, :player_id, player_id, videos) if player_id.present?
        update_attribute_of_continuous_videos_in_bulk(video, :mecha_id, mecha_id, videos) if mecha_id.present?
      end
    end
    redirect_to edit_event_path(event)
    return
  end

  private

  def update_attribute_of_continuous_videos_in_bulk(video, attr, value, videos)
    video.update_attribute(attr, value)

    while video.win? and video.next_video and (videos[video.next_video.id].nil? or not videos[video.next_video.id][attr.to_s].present?)
      video = video.next_video
      break if video.nil? or video[attr]
      video.update_attribute(attr, value)
    end
  end
end
