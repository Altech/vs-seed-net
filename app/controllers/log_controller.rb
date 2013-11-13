# -*- coding: utf-8 -*-
class LogController < ApplicationController

  def in
    @player = Player.new
  end

  def auth
    player = Player.find_by_mail(params[:mail])
    if player and player.authenticate(params[:password])
      session[:player_id] = player.id
      redirect_to '/'
    else
      if player
        flash.now.alert = 'パスワードが違います'
      else
        flash.now.alert = 'メールアドレスが違います'
      end
      render action: 'in'
    end
  end

  def out
    @current_player = nil
    session[:player_id] = nil
    redirect_to '/'
  end

end
