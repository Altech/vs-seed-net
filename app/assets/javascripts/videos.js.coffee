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
    settings.data += "&comment%5Btime%5D=" + player.getCurrentTime()

window.onPlayerReady = (event) ->
  event.target.playVideo()

## ============ show comments ============
$ () -> commentDrawer.init()
commentTimers = []

window.onPlayerStateChange = (event) ->
  # NON_PLAYING -> PLAYING
  if event.data == YT.PlayerState.PLAYING
    console.log("case1")
    time = player.getCurrentTime()
    for c in comments
      if c['time'] > time
        (-> # create new scope for the external reference of following closure
          comment = c
          timer = setTimeout((-> commentDrawer.draw comment['id'], comment['text']), (comment['time']-time)*1000)
          commentTimers.push timer)()
  # PLAYING -> NON_PLAYING
  else
    console.log("case2")
    for timer in commentTimers
      clearTimeout timer
    commentTimers = []