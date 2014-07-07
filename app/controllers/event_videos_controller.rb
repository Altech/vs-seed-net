class EventVideosController < ApplicationController
  def edit
    @event = Event.find_by_date params[:id]
    @games = @event.games
    @game_center = @event.game_center
  end

  def update
    videos = Hash[params['video'].to_a.map{|k,v| [k.to_i,v]}.sort_by(&:first)]

    videos.each do |video_id, data|
      player_id = data['player_id']
      mecha_id = MechaName.where(name: data['mecha_id']).first.mecha_id unless data['mecha_id'].nil? or data['mecha_id'].empty?
      video = Video.find(video_id)
      update_attribute_of_continuous_videos_in_bulk(video, :player_id, player_id, videos) if player_id.present?
      update_attribute_of_continuous_videos_in_bulk(video, :mecha_id, mecha_id, videos) if mecha_id.present?
    end

    redirect_to request.referer
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
