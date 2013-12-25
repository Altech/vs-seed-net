class TopController < ApplicationController
  def index
    @event_reports = EventReport.order("created_at DESC").limit(3)
  end
end
