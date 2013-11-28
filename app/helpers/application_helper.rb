module ApplicationHelper
  def display_if(boolean, default = 'inline')
    "display: #{boolean ? default : 'none'};"
  end

  def display_unless(boolean, default = 'inline')
    "display: #{boolean ? 'none' : default};"
  end
end
