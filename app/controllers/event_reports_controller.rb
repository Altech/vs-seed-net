class EventReportsController < ApplicationController
  def create(rp = params[:event_report]) # TODO validate uniqueness of event report
    redirect_to '/' and return unless current_player and current_player.admin?
    EventReport.create(body: rp[:body], event_id: rp[:event_id], author_id: current_player.id)
    redirect_to edit_event_path(Event.find(rp[:event_id]))
  end

  def update(rp = params[:event_report])
    redirect_to '/' and return unless current_player and current_player.admin?
    report = EventReport.where(event_id: rp[:event_id], author_id: current_player.id).first
    report.update_attribute(:body, rp[:body])
    redirect_to edit_event_path(Event.find(rp[:event_id]))
  end
end
