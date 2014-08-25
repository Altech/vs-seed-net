# -*- coding: utf-8 -*-
class EventsController < ApplicationController
  def index
    @events = Event.limit(20)
  end

  def show
    @event = Event.find_by_date params[:id]
    @games = @event.games
    @games_paginated = @games.page(params[:page]).per(20).order(:id)
    @game_center = @event.game_center
  end

  before_action :check_logined, only: %i[edit update]

  def edit
    event = Event.find_by_date params[:id]
    if current_player.admin? or current_player.participate?(event)
      @participants = event.players
      @event = event
      @event_report = EventReport.where(event_id: event.id, author_id: current_player.id).first || EventReport.new
      @event_report.event_id ||= @event.id
    else
      redirect_to event_path
    end
  end

  def update
    if (current_player.admin? or current_player.participate?(event)) and params[:mail]
      # add member
      event = Event.find_by_date params[:id]
      participants = event.players
      mails = params[:mail].split(/\s*,\s*/)
      mails.each do |mail|
        next if participants.map(&:mail).include? mail
        player = Player.find_by_mail(mail)
        EventParticipant.create!(event_id: event.id, player_id: player.id) if player
      end
      redirect_to edit_event_path(event)
    elsif current_player.admin? and params[:event][:thumbnail]
      # upload thumbnail
      ep = params[:event]
      event = Event.find(ep[:id])
      event.update_attribute(:thumbnail, ep[:thumbnail])
      redirect_to edit_event_path(event)
    else
      redirect_to events_path
    end
  end

  # As EventParticipantsController

  def create_event_participant
    participant = params[:event_participant]

    unless current_player.pilot
      flash[:alert] = '対戦会に参加者登録する前に、使用してるパイロットを設定してください'
      redirect_to controller: :players, action: :edit, id: current_player.to_param
      return
    end

    unless EventParticipant.where(event_id: participant[:event_id], player_id: participant[:player_id]).exists?
      EventParticipant.create!(event_id: participant[:event_id], player_id: participant[:player_id])
    end
    redirect_to event_path(Event.find(participant[:event_id]))
  end
end
