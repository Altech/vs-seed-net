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

  def _invalid_unless(obj)
    obj ? '' : '_invalid'
  end

  def ajax?
    params['ajax'] == 'true'
  end
end
