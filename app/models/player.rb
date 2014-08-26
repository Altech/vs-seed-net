# -*- coding: utf-8 -*-
class Player < ActiveRecord::Base
  validates :name,
    uniqueness: true,
    length: { minimum: 1, maximum: 10 }
  validates :mail,
    uniqueness: true,
    email_format: true
  has_secure_password
  validates :password, length: { minimum: 8, maximum: 20 }, allow_blank: true

  belongs_to :pilot
  has_many :favorites
  has_many :videos
  has_and_belongs_to_many :events, join_table: :event_participants

  def to_param
    name
  end

  def favorite?(video)
    id = case video
         when Video
           video.id
         else
           video
         end
    favorites.any?{|f| f.video_id == id}
  end

  def favorite(video)
    Favorite.where(player_id: id, video_id: video.id).first
  end

  def name_with_pilot
    if pilot
      "#{name}（#{pilot.name}）"
    end
  end

  def participate?(event)
    event = case event
            when Event then event
            when /\d\d\d\d-\d\d-\d\d/ then Event.find_by_date event
            when /\d+/ then Event.find event
            else raise ArgumentError end
    events.include? event
  end

  def admin?
    id == 1
  end

  def winning_percentage
    if videos.size > 0
      videos.select{|v| v.win_or_lose == true}.size * 100 / videos.size
    else
      0
    end
  end

  def sorted_videos
    Rails.cache.fetch("players_sorted_videos_#{id}", expires_in: 30.minutes){
      videos.sort
    }
  end
end
