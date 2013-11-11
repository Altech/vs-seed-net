window.commentDrawer =
  env:
    color: "white"
    speed: 6500
    font_size: "30px"
    height: ""
    width: ""

  init: ->
    elm = $("#comment-region")
    @elm = elm
    @elm.css "position", "relative"
    
    # this.elm.css("border", "solid 1px gray");
    @elm.css "overflow", "hidden"
    @elm.bind "selectstart", ->
      false

    @elm.bind "mousedown", ->
      false

    @env.width = "" + elm.css("width")
    @env.height = "" + elm.css("height")
    @env.width = @env.width.replace("px", "")
    @env.height = @env.height.replace("px", "")

  draw: (id, text) ->
    n = commentDrawer
    top_pos = Math.floor(Math.random() * (parseInt(n.env.height) * 0.85))
    end_left = (parseInt(n.env.width)) * -1
    cmid = "comment-" + id + ""
    com_obj = $("<div id='" + cmid + "' style='left:" + (n.env.width - 60) + "px; position:absolute;top:" + top_pos + "px;color:" + n.env.color + ";font-size:" + n.env.font_size + ";font-weight:bold;text-shadow: black 1px 1px 1px;width:100%;z-index:99999;cursor:default'>" + text + "</div>")
    $("#comment-region").append com_obj
    ((that) ->
      tmp_cmid = cmid
      com_obj.animate
        left: end_left
      ,
        duration: n.env.speed
        complete: ->
          elm_id = "#" + tmp_cmid
          $("#comment-region").remove elm_id

    ) this