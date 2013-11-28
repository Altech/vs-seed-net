class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])
    @event = @video.event
    @comments = @video.comments.map{|c| {id: c[:id], time: c[:time], text: c[:text] }}

    @new_comment = Comment.new
    @new_comment.video_id = @video.id
  end

  # exclude validation of edit authority of the user for simplicity
  def update
    video = Video.find(params[:id])
    video_param = params[:video]
    if video_param[:mecha_viewpoint_id].present?
      video.update_attribute :mecha_viewpoint_id, video_param[:mecha_viewpoint_id]
      render json: {result: 'success', contents: (view_context.link_to video.mecha.full_name, mecha_path(video.mecha), class: 'no-decoration')}
    elsif video_param[:player_viewpoint_id].present?
      video.update_attribute :player_viewpoint_id, video_param[:player_viewpoint_id]
      render json: {result: 'success', contents: (view_context.link_to video.player.name, player_path(video.player), class: 'no-decoration')}
    else
      render json: {result: 'failure'}
    end
  end
end
