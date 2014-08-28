class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, except: :complete

  before_action :keep_context
  before_action :logging_access

  # @context = :events | :mechas | :players
  def keep_context
    session[:context] ||= :events
    if %w[events mechas players].include? params[:controller]
      session[:context] = params[:controller].to_sym
    end
    @context = session[:context].to_sym
  end

  def logging_access
    return if not Rails.env.production?
    File.open(ENV['HOME'] + '/accesses.log', 'a') {|f|
      f.puts({
        method: request.method,
        path: request.fullpath,
        referer: request.referer,
        agent: request.user_agent,
        ip: request.ip}.to_json)
    }
  end

  before_filter :request_from

  def request_from
    @prev_uri = request.referer ? flash[:request_from] : flash[:request_from]
    flash[:request_from] = request.base_url + request.path
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

  def ajax?
    params['ajax'] == 'true'
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
