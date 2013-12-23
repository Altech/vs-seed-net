class Game < ActiveRecord::Base
  belongs_to :event
  has_attached_file :thumbnail,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "videos/:attachment/:id/:style.:extension"

  def video(seat)
    self.send("video_#{seat.to_s.upcase}") if seat
  end

  def video_A1
    Video.find_by_id(a1_video_id)
  end

  def video_A2
    Video.find_by_id(a2_video_id)
  end

  def video_B1
    Video.find_by_id(b1_video_id)
  end

  def video_B2
    Video.find_by_id(b2_video_id)
  end

  def has_video_of?(seat)
    !self.send("#{seat}_video_id").nil?
  end

  def next_game
    if event_id
      Game.where(index_of_event: index_of_event+1, event_id: event_id).first
    end
  end

  def previous_game
    if event_id
      Game.where(index_of_event: index_of_event-1, event_id: event_id).first
    end
  end
end
