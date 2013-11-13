class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_player
    if session[:player_id]
      @current_player ||= Player.find(session[:player_id])
    end
  end

  helper_method :current_player
end
