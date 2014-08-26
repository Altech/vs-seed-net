## =========== Video Modal ============
window.setThumbanilEvent = ->
  $(".thumbnail").click (e) ->
    if parseInt($(window).width()) > spMaxWidth
      e.preventDefault()
      $('#now-loading-cover').show()
      id = parseInt($(this).attr('data-video-id'))
      $('#video-modal').load ('/videos/'+ id + '?ajax=true'), (result) ->
        $('#now-loading-cover').hide()
        $('#video-modal').modal({show:true})

$ ($) ->
  stopIfHidden = ->
    try 
      if window.isPlayerModal and !$('#video-modal').is(":visible") and window.player?
        window.player.stopVideo()
    finally
      setTimeout(stopIfHidden , 300)

  setTimeout(stopIfHidden , 300)

window.setVideoNavEvents = ->
  for str in ['prev', 'exchange', 'next']
    ((str) ->
        $(".modal-dialog .video-nav img.#{str}").click (e) ->
          e.preventDefault()
          if $(this).attr('data-video-id') != ''
            id = parseInt($(this).attr('data-video-id'))
            $('#video-modal').load ('/videos/'+ id + '?ajax=true'))(str)
  $('#video-modal').on('hide', ->
    alert('called')
    player.stopVideo());

window.onPlayerReady = (event) ->
  ua = window.navigator.userAgent.toLowerCase()
  if ua.indexOf('iphone') == -1 and ua.indexOf('ipad') == -1 and ua.indexOf('android') == -1
    event.target.playVideo()

## ============ Create or Edit information of the video ============
window.setVideoEditEvents = ->
  for str in ['.viewpoint', '.partner']
    ((str) ->      
      for info in ['.player', '.mecha']
        ((info) ->
          
          $("#{str} button.edit").click ->
            $("#{str} #{info} .select").toggle()
            $("#{str} #{info} .data").toggle()
            
          $("#{str} #{info} select").change ->
            $.ajax({
              url: $(this).attr('post_url')
              type: 'PUT',
              data: $(this).serialize(),
              beforeSend: (xhr, settings) ->
                $(this).attr('disabled', true)
              complete: (xhr, textStatus) ->
                $(this).attr('disabled', false)
              success: (result, textStatus, xhr) ->
                switch result['result']
                  when 'success'
                    $("#{str} #{info} .select").hide()
                    $("#{str} #{info} .data").html(result['contents']).show()
                  when 'failure'
                    null
              })
          )(info)
        )(str)
