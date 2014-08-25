## =========== Video Modal ============
$ ($) ->
  $(".thumbnail").click (e) ->
    if parseInt($(window).width()) > spMaxWidth
      e.preventDefault()
      id = parseInt($(this).attr('data-video-id'))
      $('#video-modal').load ('/videos/'+ id + '?ajax=true'), (result) ->
        $('#video-modal').modal({show:true})

  stopIfHidden = ->
    if !$('#video-modal').is(":visible") and window.player != undefined
      window.player.stopVideo()
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

## ============ create or edit information of the video ============
for str in ['player', 'mecha']
  ((str) ->      
    $ ($) ->
      $(document).on "click", "tr.#{str} button.edit", ->
        $("tr.#{str} form").show()
        $("tr.#{str} button.edit").hide()
        $("tr.#{str} span.contents").hide()
        
      $(document).on "submit", "tr.#{str} form", (event) ->
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
