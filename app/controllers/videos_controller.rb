class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])
    @event = @video.game.event
    @game = @video.game

    @favorite = current_player.favorite(@video) if current_player

    if ajax?
      render partial: 'show_modal', layout: false and return
    end
  end

  # exclude validation of edit authority for simplicity
  def update
    video = Video.find(params[:id])
    video_param = params[:video]
    if video_param[:mecha_id].present?
      update_attribute_of_continuous_videos(video, :mecha_id, video_param[:mecha_id])
      render json: {result: 'success', contents: (view_context.link_to video.mecha.full_name, mecha_path(video.mecha), class: 'no-decoration')}
    elsif video_param[:player_id].present?
      update_attribute_of_continuous_videos(video, :player_id, video_param[:player_id])
      render json: {result: 'success', contents: (view_context.link_to video.player.name, player_path(video.player), class: 'no-decoration')}
    else
      render json: {result: 'failure'}
    end
  end

  private

  def update_attribute_of_continuous_videos(video, attr, value)
    video.update_attribute(attr, value)
    if video.win?
      video = video.next_video
      loop do
        break if video.nil? or video[attr]
        video.update_attribute(attr, value)
        if video.lose?
          break
        else
          video = video.next_video
        end
      end
    end
  end
end
