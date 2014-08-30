class TopController < ApplicationController
  def index
    render layout: false if request.headers['X-PJAX']
  end
end
