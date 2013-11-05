class Event < ActiveRecord::Base
  has_many :videos
  belongs_to :game_center

  default_scope { order('held_at desc') }
end
