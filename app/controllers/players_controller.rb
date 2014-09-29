# -*- coding: utf-8 -*-
class PlayersController < ApplicationController
  def index
    players = Player.all.sort_by(&:winning_percentage).reverse
    @players =
      players.select{|player| player.videos.size > 17} +
      players.select{|player| 7 < player.videos.size and player.videos.size <= 17} +
      players.select{|player| player.videos.size <= 7}
    @stats = Rails.cache.fetch(:stats_of_players, expires_in: 3.day) {
      Hash[players.map{|player| [player.id, calc_stat(player, :ratio)]}]
    }
    @players.select{|player| @stats[player.id].nil?}.each do |player|
      @stats[player.id] = calc_stat(player, :ratio)
    end
    render layout: false if request.headers['X-PJAX']
  end

  def show
    @player = Player.find_by_name(params[:id]) or raise ActiveRecord::RecordNotFound
    if params[:filtering_id].to_i == 0
      @videos = @player.sorted_videos
    else
      @videos = @player.videos.select{|video| video.mecha_id == params[:filtering_id].to_i}.sort
    end
    @stat = calc_stat(@player)
    render layout: false if ajax?
    render layout: false if request.headers['X-PJAX']
  end

  private

  def calc_stat(player, type = :absolute)
    videos = player.videos.select(&:first_game?)
    stat = player.videos
      .select(&:first_game?)
      .map(&:mecha)
      .select{|o| !o.nil?}
      .group_by(&:id)
      .map{|id,mechas| [mechas.first.nickname, mechas.size]}
      .sort_by(&:last)
      .reverse
    case type
    when :absolute
      stat
    when :ratio
      sum = stat.map(&:last).reduce(&:+).to_f
      stat.map{|name, size| [name, ((size/sum)*100).to_i]}
    end
  end
end
