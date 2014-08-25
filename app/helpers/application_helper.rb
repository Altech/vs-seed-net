module ApplicationHelper
  def display_if(boolean, default = 'inline')
    "display: #{boolean ? default : 'none'};"
  end

  def display_unless(boolean, default = 'inline')
    "display: #{boolean ? 'none' : default};"
  end

  def _selected_if_controller(controller)
    params[:controller] == controller.to_s ? '_selected' : ''
  end
end
