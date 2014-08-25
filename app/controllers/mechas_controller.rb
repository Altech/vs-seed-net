class MechasController < ApplicationController
  def index
    @mechas_of_costs = Mecha.find(:all).group_by(&:cost)
  end

  def show
    @mecha = Mecha.find_by_name(params[:id])
    if params[:filtering_id].to_i == 0
      @videos = @mecha.videos.sort
    else
      @videos = @mecha.videos.select{|video| video.partners_video.try(:mecha_id) and video.partners_video.mecha_id == params[:filtering_id].to_i}.sort
    end
    render layout: false if ajax?
  end
end
