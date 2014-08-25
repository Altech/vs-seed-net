module VideosHelper
  def next_video_path(video)
    if video.next_video(@context)
      video_path(video.next_video(@context))
    else
      "#"
    end
  end

  def previous_video_path(video)
    if video.previous_video(@context)
      video_path(video.previous_video(@context))
    else
      '#'
    end
  end

  def partners_video_path(video)
    if video.partners_video
      video_path(video.partners_video)
    else
      '#'
    end
  end

  def partners_video_path(video)
    if video.partners_video
      video_path(video.partners_video)
    else
      '#'
    end
  end

  def link_to_next_video_if_exists(video, opt = {}, &block)
    if @video.next_video(@context)
      content_tag(:a, capture(&block), opt.merge(href: next_video_path(@video)))
    else
      capture(&block)
    end
  end

  def link_to_previous_video_if_exists(video, opt = {}, &block)
    if @video.previous_video(@context)
      content_tag(:a, capture(&block), opt.merge(href: previous_video_path(@video)))
    else
      capture(&block)
    end
  end

  def link_to_partners_video_if_exists(video, opt = {}, &block)
    if @video.partners_video
      content_tag(:a, capture(&block), opt.merge(href: partners_video_path(@video)))
    else
      capture(&block)
    end
  end

  def player_info_editable(video)
    current_player and current_player.participate? video.game.event
  end

  def mecha_info_editable(video)
    current_player
  end
end
