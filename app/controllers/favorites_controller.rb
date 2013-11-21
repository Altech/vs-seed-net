class FavoritesController < ApplicationController
  before_action :check_logined

  def index
    @favorites = current_player.favorites
  end

  def create
    Favorite.create!(video_id: params['video_id'], player_id: current_player.id)
    render json: {result: 'success'}
  end

  def destroy
    Favorite.where(video_id: params['video_id'], player_id: current_player.id).first.destroy
    render json: {result: 'success'}
  end
end
