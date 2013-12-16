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
      flash[:lets_login] = 'プレイヤー登録が完了しました。ログインしてください。'
      redirect_to login_path
    else
      flash.now.alert = player.errors.full_messages.join("<br>")
      @player = Player.new(player_params_without_password)
      render action: 'new' and return
    end
  end

  def edit
    player = Player.find_by_name(params[:id])
    if current_player and current_player == player
      @player = player
    end
  end

  def update
    player = Player.find_by_name(params[:id])
    if current_player and current_player == player
      player.update_attributes(player_params_for_edit)
      @player = Player.find(player.id)
      error_messages = player.errors.full_messages_for(:name) + player.errors.full_messages_for(:mail)
      if error_messages.size > 0
        flash[:alert] = error_messages.join("<br>")
      else
        flash[:success] = "プレイヤー情報が更新されました"
      end
      redirect_to action: :edit, id: @player.to_param
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

  alias :player_params_for_edit :player_params_without_password
end
