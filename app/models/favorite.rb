class Favorite < ActiveRecord::Base
  belongs_to :video
  belongs_to :player

  validates :player_id, uniqueness: {scope: :video_id}
end
