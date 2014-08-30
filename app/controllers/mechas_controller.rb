class MechasController < ApplicationController
  def index
    @mechas_of_costs = Mecha.find(:all).group_by(&:cost)
    render layout: false if request.headers['X-PJAX']
  end

  def show
    @mecha = Mecha.find_by_name(params[:id])
    if params[:filtering_id].to_i == 0
      @videos = @mecha.sorted_videos
    else
      @videos = @mecha.videos.select{|video| video.partners_video.try(:mecha_id) and video.partners_video.mecha_id == params[:filtering_id].to_i}.sort
    end
    @stat = calc_stat(@mecha)
    render layout: false if ajax?
    render layout: false if request.headers['X-PJAX']
  end

  private

  def calc_stat(mecha)
    mecha.videos
      .select(&:first_game?)
      .select{|video| video.partners_video.try(:mecha_id)}
      .map{|video| video.partners_video.mecha}
      .group_by(&:id)
      .map{|id,mechas| [mechas.first.nickname, mechas.size]}
      .sort_by(&:last)
      .reverse
  end
end
