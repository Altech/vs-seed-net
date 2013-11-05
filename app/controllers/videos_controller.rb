class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])
    @event = @video.event
    render :layout => nil
  end
end
