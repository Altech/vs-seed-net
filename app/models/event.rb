class Event < ActiveRecord::Base
  has_many :videos
  has_and_belongs_to_many :players, join_table: :event_participants
  belongs_to :game_center

  default_scope { order('held_at desc') }

  def self.find_by_date(d)
    t = case d
        when Time
          d
        when String
          Time.parse d
        when Date
          t.to_time
        end
    Event.where(held_at: t..(t + 1.day - 1)).first or raise ActiveRecord::RecordNotFound
  end

  def to_param
    held_at.strftime("%Y-%m-%d")
  end
end
