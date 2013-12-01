window.commentDrawer =
  env:
    color: "white"
    speed: 6800
    font_size: "18pt"
    height: ""
    width: ""

  init: ->
    elm = $("#comment-region")
    @elm = elm
    @elm.css "position", "relative"
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
    com_obj = $("<div id='" + cmid + "' style='left:" + (n.env.width) + "px; position:absolute;top:" + top_pos + "px;color:" + n.env.color + ";font-size:" + n.env.font_size + ";text-shadow:black 0px 0px 2px; opacity:0.85; font-weight:bold; width:800px;text-align:left; z-index:99999;cursor:default'>" + text + "</div>")
    $("#comment-region").append com_obj
    ((that) ->
      tmp_cmid = cmid
      com_obj.animate
        left: end_left - 600
      ,
        duration: n.env.speed,
        easing: 'linear',
        complete: ->
          elm_id = "#" + tmp_cmid
          $("#comment-region").remove elm_id

    ) this