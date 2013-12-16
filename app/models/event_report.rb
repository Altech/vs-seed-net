class EventReport < ActiveRecord::Base
  belongs_to :event
  belongs_to :player, foreign_key: :author_id
end
