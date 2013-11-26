class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :logging_access

  def logging_access
    return if not Rails.env.production?
    return if current_player and current_player.admin?
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

  def check_logined
    unless current_player
      redirect_to '/login'
    end
  end

  if Rails.env.production?
    rescue_from Exception, with: :render_500
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404

    def render_404(exception = nil)
      logger.error "Rendering 404 with exception: #{exception.message} (#{exception.class})" if exception
      render template: "errors/error_404", status: 404, content_type: 'text/html'
    end

    def render_500(exception = nil)
      logger.error "Rendering 500 with exception: #{exception.message} (#{exception.class})" if exception
      render template: "errors/error_500", status: 404, content_type: 'text/html'
    end
  end
end
