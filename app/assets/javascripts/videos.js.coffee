##  ============ handle comments (add time) ============
$ ($) ->
  $('#new_comment').bind 'ajax:success', (data, response, _) ->
    switch response['comment_post']
      when 'success'
        commentDrawer.draw response['comment']['id'], response['comment']['text']
        $('#comment_text').val('')
      when 'failure'
        $('#alert-message').text(response['message']); $('#alert-message').show()
        setTimeout (->
          $('#alert-message').text(""); $('#alert-message').hide()), 3000
  $('#new_comment').bind 'ajax:beforeSend', (_, __, settings) ->
    t = player.getCurrentTime()
    settings.data += "&comment%5Btime%5D=" + (if t != 0 then t else window.currentPlayerTime)

window.onPlayerReady = (event) ->
  if window.navigator.userAgent.toLowerCase().indexOf('iphone') == -1
    event.target.playVideo()

## ============ show comments ============
$ () -> commentDrawer.init()
commentTimers = []

window.onPlayerStateChange = (event) ->
  # NON_PLAYING -> PLAYING
  if event.data == YT.PlayerState.PLAYING
    commentDrawer.init()
    time = player.getCurrentTime()
    for c in comments
      if c['time'] == 0
        commentDrawer.draw c['id'], c['text']
      else if c['time'] > time
        (-> # create new scope for the external reference of following closure
          comment = c
          timer = setTimeout((-> commentDrawer.draw comment['id'], comment['text']), (comment['time']-time)*1000)
          commentTimers.push timer)()
  # PLAYING -> NON_PLAYING
  else
    for timer in commentTimers
      clearTimeout timer
    commentTimers = []

## ============ persuade login ============
$ ($) ->
  $('.disabled-comment').popover
    html: true,
    placement: 'bottom',
    content: 'コメントするには<a href="/login">ログイン</a><br>する必要がありますです。'
## ============ control panel ============
$ ($) ->
  $('.play-and-pause').click ->
    switch player.getPlayerState()
      when YT.PlayerState.PLAYING
        player.pauseVideo()
        btn = $('.play-and-pause')
        btn.removeClass 'fa-pause'
        btn.addClass 'fa-play'
      when YT.PlayerState.PAUSED
        player.playVideo()
        btn = $('.play-and-pause')
        btn.removeClass 'fa-play'
        btn.addClass 'fa-pause'
      when YT.PlayerState.BUFFERING
        null
      else
        player.playVideo()
        btn = $('.play-and-pause')
        btn.removeClass 'fa-play'
        btn.addClass 'fa-pause'
    return false
  # favorite
  $('.favorite-video.disabled').popover
    html: true,
    placement: 'right',
    content: 'お気に入りは<a href="/login">ログイン</a><br>しないと使えません。'
  $('.favorite-video.enabled').click ->
    if $('.favorite-video.enabled i').hasClass('fa-star-o')
      $.post('/favorites', {video_id: $(this).attr('data-video-id')},)
       .done(-> i = $('.favorite-video.enabled i'); i.removeClass('fa-star-o'); i.addClass('fa-star'))
    else
      $.ajax({type: 'DELETE', url: '/favorites', data: {video_id: $(this).attr('data-video-id')}})
       .done(-> i = $('.favorite-video.enabled i'); i.removeClass('fa-star'); i.addClass('fa-star-o'))

## ============ fix for iPhone ============
# getCurrentTime() is available only playing in iPhone
window.currentPlayerTime = 0
window.getCurrentPlayerTimeLoop = ->
  if player and player.getPlayerState() == YT.PlayerState.PLAYING
    t = player.getCurrentTime()
    if t != 0 
      window.currentPlayerTime = t
  setTimeout(getCurrentPlayerTimeLoop, 500)