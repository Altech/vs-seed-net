class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])
    @event = @video.event
    @comments = @video.comments.map{|c| {id: c[:id], time: c[:time], text: c[:text] }}

    @new_comment = Comment.new
    @new_comment.video_id = @video.id

    # [TODO]
    # handle cases of modal window
  end
end
