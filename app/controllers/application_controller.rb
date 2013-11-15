class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :logging_access

  def logging_access
    return unless Rails.env.production?
    logger = Fluent::Logger::FluentLogger.new(nil, :host => 'localhost')
    logger.post('production.vs_seed.access',
                method: request.method,
                path: request.fullpath,
                referer: request.referer,
                agent: request.user_agent,
                ip: request.ip
                )
  end

  helper_method :current_player

  def current_player
    if session[:player_id] and Player.exists?(session[:player_id])
      @current_player ||= Player.find(session[:player_id])
    end
  end
end
