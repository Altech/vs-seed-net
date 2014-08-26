class Video < ActiveRecord::Base
  belongs_to :mecha
  # belongs_to mecha for each fours

  def <=>(other)
    if self.game.event == other.game.event
      if self.game.index_of_event == other.game.index_of_event
        self.seat.to_s <=> other.seat.to_s
      else
        self.game.index_of_event <=> other.game.index_of_event
      end
    else
      self.game.event <=> other.game.event
    end
  end

  def next_video(context = :events)
    case context
    when :events
      next_game = game.next_game
      if next_game and next_game.has_video_of?(seat)
        next_game.video(seat)
      end
    when :mechas
      return nil if mecha.nil?
      video_ids = mecha.sorted_videos.map(&:id)
      next_index = video_ids.index(self.id) + 1
      return nil if video_ids[next_index].nil?
      Video.find(video_ids[next_index])
    when :players
      return nil if player.nil?
      video_ids = player.sorted_videos.map(&:id)
      next_index = video_ids.index(self.id) + 1
      return nil if video_ids[next_index].nil?
      Video.find(video_ids[next_index])
    else
      raise "Invalid context(#{context})"
    end
  end

  def previous_video(context = :events)
    case context
    when :events
      previous_game = game.previous_game
      if previous_game and previous_game.has_video_of?(seat)
        previous_game.video(seat)
      end
    when :mechas
      return nil if mecha.nil?
      video_ids = mecha.sorted_videos.map(&:id)
      previous_index = video_ids.index(self.id) - 1
      return nil if previous_index < 0
      Video.find(video_ids[previous_index])
    when :players
      return nil if player.nil?
      video_ids = player.sorted_videos.map(&:id)
      previous_index = video_ids.index(self.id) - 1
      return nil if previous_index < 0
      Video.find(video_ids[previous_index])
    else
      raise "Invalid context(#{context})"
    end
  end

  def partners_video
    case seat
    when :a1 then game.video(:a2)
    when :a2 then game.video(:a1)
    when :b1 then game.video(:b2)
    when :b2 then game.video(:b1)
    end
  end

  def is_last_video_of_event
    next_video ? false : true
  end

  def player
    Player.find_by_id(player_id)
  end

  def mecha
    Mecha.find_by_id(mecha_id)
  end

  def game
    @game || (seat ? @game = Game.send("find_by_#{seat}_video_id", id) : nil)
  end

  def seat
    @seat || begin
               @seat = if    Game.find_by_a1_video_id(id)
                         :a1
                       elsif Game.find_by_a2_video_id(id)
                         :a2
                       elsif Game.find_by_b1_video_id(id)
                         :b1
                       elsif Game.find_by_b2_video_id(id)
                         :b2
                       end
             end
  end

  def thumbnail
    game.thumbnail
  end

  def win?
    win_or_lose
  end

  def lose?
    !win?
  end

  def first_game?
    previous_video(:events) ? previous_video.lose? : true
  end

  # [TODO]
  # impl proxy as Youtube DATA API

  def uri
    "http://www.youtube.com/watch?v=#{youtube_video_id}"
  end

end
