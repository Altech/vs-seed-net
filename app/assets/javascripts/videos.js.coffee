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
