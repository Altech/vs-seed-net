# -*- coding: utf-8 -*-
class LogController < ApplicationController

  def in
    if not current_player
      @player = Player.new
      flash[:login_redirect_dest] = @prev_uri
    else
      redirect_to @prev_uri
    end
  end

  def auth
    player = Player.find_by_name(params[:mail])
    if player and player.authenticate(params[:password])
      session[:player_id] = player.id
      redirect_to flash[:login_redirect_dest]
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
    redirect_to @prev_uri
  end

end
