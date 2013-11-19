# -*- coding: utf-8 -*-
class Player < ActiveRecord::Base
  validates :name,
    uniqueness: true,
    length: { minimum: 1, maximum: 10 }
  validates :mail,
    uniqueness: true,
    email_format: true
  has_secure_password
  validates :password, length: { minimum: 8, maximum: 20 }

  has_many :comments
  has_many :favorites

  def favorite?(video_or_video_id)
    id = case video_or_video_id
         when Video
           video_or_video_id.id
         else
           video_or_video_id.id
         end
    favorites.any?{|f| f.video_id == id}
  end

  def admin?
    id == 1
  end
end
