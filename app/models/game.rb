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

  def videos
    ids = [a1_video_id, a2_video_id, b1_video_id, b2_video_id]
    ids.select{|e| !e.nil?}.map{|id|
      Video.find_by_id(id)
    }
  end

  def has_video_of?(seat)
    !self["#{seat}_video_id"].nil?
  end

  def include_player?(player_or_id)
    player = Player.find(player_or_id) unless Player === player_or_id
    videos.any?{|video| video.try(:player) and video.player == player}
  end

  def viewpoint_of(player_or_id)
    player = Player.find(player_or_id) unless Player === player_or_id
    videos.find{|video| video.try(:player) and video.player == player }
  end

  def include_unknown_player?
    videos.any?{|video| video.player.nil?}
  end

  def viewpoint_of_unknown_player
    videos.find{|video| video.player.nil?}
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
