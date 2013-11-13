module VideosHelper

  def next_video_path(video)
    if video.next_video
      video_path(video.next_video.id)
    else
      "#"
    end
  end

  def previous_video_path(video)
    if video.previous_video
      video_path(video.previous_video.id)
    else
      '#'
    end
  end

  def link_to_next_video_if_exists video, &block
    if @video.next_video
      content_tag(:a, capture(&block), href: next_video_path(@video))
    else
      capture(&block)
    end
  end

  def link_to_previous_video_if_exists video, &block
    if @video.previous_video
      content_tag(:a, capture(&block), href: previous_video_path(@video))
    else
      capture(&block)
    end
  end

end
