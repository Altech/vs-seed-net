module ApplicationHelper
  def display_if(boolean, default = 'inline')
    "display: #{boolean ? default : 'none'};"
  end

  def display_unless(boolean, default = 'inline')
    "display: #{boolean ? 'none' : default};"
  end

  def _selected_if(context)
    if %w[top events mechas players].include? params[:controller]
      params[:controller] == context.to_s ? '_selected' : ''
    elsif @context == context.to_sym
      '_selected'
    else
      ''
    end
  end

  def _disabled_unless(obj)
    obj ? '' : '_disabled'
  end

  def ajax?
    params['ajax'] == 'true'
  end

  def background_image(path)
    "background-image: url('#{asset_path(path)}')"
  end

  def nicovideo_path(video)
    video.nico_video_id ? "http://www.nicovideo.jp/watch/#{video.nico_video_id}" : nil
  end
end
