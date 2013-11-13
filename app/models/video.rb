class Video < ActiveRecord::Base
  belongs_to :event
  belongs_to :mecha
  has_many :comments
  # belongs_to mecha for each fours
  has_attached_file :thumbnail,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "videos/:attachment/:id/:style.:extension"

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

  # [TODO]
  # impl proxy as Youtube DATA API

  def uri
    "http://www.youtube.com/watch?v=#{youtube_video_id}"
  end

end
