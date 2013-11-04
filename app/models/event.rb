class Event < ActiveRecord::Base
  has_many :videos
  belongs_to :game_center
end
