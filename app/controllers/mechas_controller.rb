class MechasController < ApplicationController
  def index
    @mechas_of_costs = Mecha.find(:all).group_by(&:cost)
  end

  def show
    @mecha = Mecha.find_by_name(params[:id])
    @videos = @mecha.videos
  end
end
