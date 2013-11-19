class FavoritesController < ApplicationController
  def index
    if current_player
      @favorites = current_player.favorites
    else
      redirect_to '/login'
    end
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
