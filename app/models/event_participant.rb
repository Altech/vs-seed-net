class EventParticipant < ActiveRecord::Base
  belongs_to :event
  belongs_to :player
  
  validates :player_id, uniqueness: {scope: :event_id}
end
