# -*- coding: utf-8 -*-
class PlayersController < ApplicationController
  def show
    @player = Player.find_by_name(params[:id]) or raise ActiveRecord::RecordNotFound
    videos = @player.videos
    if videos.size > 0
      @mechas_ratio =
        [['機体','使用率']] +
        videos.map(&:mecha).select{|o| !o.nil?}.group_by(&:id).map{|id,mechas| [mechas.first.nickname, mechas.size]}.sort_by(&:last).reverse
      @winning_percentage = videos.select{|v| v.win_or_lose == true}.size * 100 / videos.size
    end
  end

  def new
    @player = Player.new
  end

  def create
    player = Player.create(player_params)
    if player.valid?
      redirect_to login_path
    else
      flash.now.alert = player.errors.full_messages.join("<br>")
      @player = Player.new(player_params_without_password)
      render action: 'new' and return
    end
  end

  private

  def player_params
    params.require(:player).permit(:name,:password,:password_confirmation,:mail)
  end

  def player_params_password
    params.require(:player).permit(:password,:password_confirmation)
  end

  def player_params_without_password
    params.require(:player).permit(:name,:mail)
  end

end
