class FavoritesController < ApplicationController
  before_action :check_logined

  def index
    @favorites = current_player.favorites
  end

  def create
    @favorite = Favorite.create!(video_id: params['video_id'], player_id: current_player.id)
    render json: {result: 'success', contents: (render_to_string partial: 'memo_form')}
  end

  def update
    fav = Favorite.find(params[:id])
    if current_player and current_player.id = fav.player_id
      params[:favorite][:memo] = nil if params[:favorite][:memo].strip.empty?
      fav.update_attribute(:memo, view_context.strip_tags(params[:favorite][:memo]))
      render json: {result: 'success', contents: params[:favorite][:memo].try(:gsub, "\n","<br>")}
    end
  end

  def destroy
    Favorite.where(video_id: params['video_id'], player_id: current_player.id).first.destroy
    render json: {result: 'success'}
  end
end
