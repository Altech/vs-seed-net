class Event < ActiveRecord::Base
  has_many :games
  has_and_belongs_to_many :players, join_table: :event_participants
  belongs_to :game_center
  has_one :event_report
  has_attached_file :thumbnail,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "events/:attachment/:id/:style.:extension"

  default_scope { order('held_at desc') }

  def <=>(other)
    if self.held_at == other.held_at
      0
    elsif self.held_at > other.held_at
      -1
    else
      1
    end
  end

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
