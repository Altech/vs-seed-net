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

  has_many :comments
  has_many :favorites
  has_many :videos, foreign_key: :player_viewpoint_id
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
end
