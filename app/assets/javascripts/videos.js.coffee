##  ============ handle comments (add time) ============
$ ($) ->
  $('#new_comment').bind 'ajax:success', (data, response, _) ->
    switch response['result']
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
  ua = window.navigator.userAgent.toLowerCase()
  if ua.indexOf('iphone') == -1 and ua.indexOf('ipad') == -1 and ua.indexOf('android') == -1
    event.target.playVideo()

## ============ show comments ============
$ () -> commentDrawer.init()
commentTimers = []

window.onPlayerStateChange = (event) ->
  # NON_PLAYING -> PLAYING  or  PLAYING -(FIRST_SEEK)-> PLAYING
  if event.data == YT.PlayerState.PLAYING
    for timer in commentTimers
      clearTimeout timer
    commentTimers = []
    
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

  # * -> ENDED
  if event.data == YT.PlayerState.ENDED and $.cookie("auto-transition") == 'true'
    next_url = $('.next-video a').first().attr("href")
    if next_url
      document.location = next_url

## ============ seek to the position of the comment ============
$ ($) ->
  $('table.comments tbody tr.comment').click ->
    ua = window.navigator.userAgent.toLowerCase()
    diff = 6.0
    if ua.indexOf('iphone') == -1 and ua.indexOf('ipad') == -1 and ua.indexOf('android') == -1
      time = parseFloat($(this).attr('data-second'))
      window.player.seekTo(time - diff)
    # reset comment timers
    for timer in commentTimers
      clearTimeout timer
    commentTimers = []
    for c in comments
      if c['time'] > time - diff
        (-> # create new scope for the external reference of following closure
          comment = c
          timer = setTimeout((-> commentDrawer.draw comment['id'], comment['text']), (comment['time']-time+diff)*1000)
          commentTimers.push timer)()

## ============ control panel ============
$ ($) ->
  $('.favorite-video.disabled').popover
    html: true,
    placement: 'right',
    content: 'お気に入りは<a href="/login">ログイン</a><br>すると使えます。'
  $('.favorite-video.enabled').click ->
    if $('.favorite-video.enabled i').hasClass('fa-star-o')
      $.post('/favorites', {video_id: $(this).attr('data-video-id')},)
       .done(-> i = $('.favorite-video.enabled i'); i.removeClass('fa-star-o'); i.addClass('fa-star'))
    else
      $.ajax({type: 'DELETE', url: '/favorites', data: {video_id: $(this).attr('data-video-id')}})
       .done(-> i = $('.favorite-video.enabled i'); i.removeClass('fa-star'); i.addClass('fa-star-o'))
  
  $('.auto-transition').click ->
    li = $(this)
    if $.cookie("auto-transition") == 'true'
      $.cookie("auto-transition", 'false', { expires: 180 })
      li.html("<i class=\"fa fa-dot-circle-o\">")
    else
      $.cookie("auto-transition", 'true', { expires: 180 })
      li.html("<i class=\"fa fa-refresh\">")
  $('.auto-transition').popover
    html: true,
    placement: 'bottom',
    trigger: 'manual',
    content: '自動的に次の動画に進むようにします'
  $('.auto-transition').click ->
    count = $.cookie("auto-transition-show-count")
    count = if count == undefined then 0 else parseInt(count)
    if $.cookie("auto-transition") == 'true' and count < 3
      $(this).popover('show')
      $.cookie("auto-transition-show-count", count + 1)
    setTimeout((-> $('.auto-transition').popover('hide')), 2000)

## ============ fix for iPhone ============
# getCurrentTime() is available only playing in iPhone
window.currentPlayerTime = 0
window.getCurrentPlayerTimeLoop = ->
  if player and player.getPlayerState() == YT.PlayerState.PLAYING
    t = player.getCurrentTime()
    if t != 0 
      window.currentPlayerTime = t
  setTimeout(getCurrentPlayerTimeLoop, 500)

## ============ create or edit information of the video ============
for str in ['player', 'mecha']
  ((str) ->      
    $ ($) ->
      $("tr.#{str} button.edit").click ->
        $("tr.#{str} form").show()
        $("tr.#{str} button.edit").hide()
        $("tr.#{str} span.contents").hide()
        
      $("tr.#{str} form").submit (event) ->
        event.preventDefault()
    
        form = $(this)
        button = form.find('button')

        if form.find('select').val() == ''
          $("tr.#{str} form").hide()
          $("tr.#{str} button.edit").show()
          $("tr.#{str} span.contents").show()
        
        $.ajax({
          url: form.attr('action'),
          type: 'PUT',
          data: form.serializeArray(),
          beforeSend: (xhr, settings) ->
            button.attr('disabled', true)
          complete: (xhr, textStatus) ->
            button.attr('disabled', false)
          success: (result, textStatus, xhr) ->
            switch result['result']
              when 'success'
                $("tr.#{str} form").hide()
                $("tr.#{str} button.edit").show()
                $("tr.#{str} span.contents").html(result['contents']).show()
              when 'failure'
                null
          }))(str)
