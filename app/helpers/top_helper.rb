module TopHelper
  def activate_if_controller(controller)
    params[:controller] == controller.to_s ? 'active' : ''
  end
end
