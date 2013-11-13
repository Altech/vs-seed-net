# -*- coding: utf-8 -*-
class PlayersController < ApplicationController
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
