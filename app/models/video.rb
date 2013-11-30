class Video < ActiveRecord::Base
  belongs_to :event
  belongs_to :mecha
  has_many :comments
  # belongs_to mecha for each fours
  has_attached_file :thumbnail,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "videos/:attachment/:id/:style.:extension"

  def <=>(other)
    if self.event == other.event
      self.index_of_event <=> other.index_of_event
    else
      self.event <=> other.event
    end
  end

  def next_video
    if event_id
      Video.where(index_of_event: index_of_event+1, event_id: event_id).first
    end
  end

  def previous_video
    if event_id
      Video.where(index_of_event: index_of_event-1, event_id: event_id).first
    end
  end

  def is_last_video_of_event
    next_video ? false : true
  end

  def player
    Player.find_by_id(player_viewpoint_id)
  end

  def mecha
    Mecha.find_by_id(mecha_viewpoint_id)
  end

  # [TODO]
  # impl proxy as Youtube DATA API

  def uri
    "http://www.youtube.com/watch?v=#{youtube_video_id}"
  end

end
