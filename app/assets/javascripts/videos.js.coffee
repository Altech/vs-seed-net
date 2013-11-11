$ ($) ->
  $('#new_comment').bind 'ajax:success', (data, response, _) ->
    switch response['comment_post']
      when 'success'
        alert "成功：文字が流れる[TODO]"
      when 'failure'
        alert "失敗：" + response['message']
  $('#new_comment').bind 'ajax:beforeSend', (_, __, settings) ->
    settings.data += "&comment%5Btime%5D=" + Math.round(player.getCurrentTime())