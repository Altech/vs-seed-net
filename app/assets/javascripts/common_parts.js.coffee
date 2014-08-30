## =========== Back button and Forward button in iOS App ============
# alert(history.length)

if (window.backCount == undefined)
  window.backCount = 0

$ ->
  $("#back-button").click (e) ->
    $('#invalidate-cover').show()
    history.back()
    backCount += 1
    $('#invalidate-cover').hide()
  $("#forward-button").click (e) ->
    $('#invalidate-cover').show()
    history.forward()
    backCount -= 1
    $('#invalidate-cover').hide()

window.setViewOfBackAndForward = ->
  setTimeout((->
    if history.length > 1
      $('#back-button').show()
      $('#back-button-disabled').hide()
    if backCount > 0
      $('#forward-button').show()
      $('#forward-button-disabled').hide()
  ), 200)

## =========== Video Filtering ============
$ ($) ->
  $('.filter-by-selection select').change ->
    nowLoadingId = if isPC() then '#now-loading-at-nav' else '#now-loading-at-filter'
    $(nowLoadingId).show()
    $('#invalidate-cover').show()
    path = window.location.pathname + "?filtering_id=" + $(this).val()
    $('#replaceable').load (path + "&ajax=true"), (result) ->
      $(nowLoadingId).hide()
      $('#invalidate-cover').hide()

window.setThumbanilEvent = ->
  $(".thumbnail").click (e) ->
    if isPC()
      e.preventDefault()
      $('#now-loading-at-nav').show()
      $('#invalidate-cover').show()
      id = parseInt($(this).attr('data-video-id'))
      $('#video-modal').load ('/videos/'+ id + '?ajax=true'), (result) ->
        $('#now-loading-at-nav').hide()
        $('#invalidate-cover').hide()
        $('#video-modal').modal({show:true})

## =========== Show Chart ============
baseChartData = 
    colors: [
      "#3366CC"
      "#DC3912"
      "#FF9900"
      "#109618"
      "#990099"
      "#0099C6"
      "#DD4477"
      "#66AA00"
      "#B82E2E"
    ]
    chart:
      plotBackgroundColor: null
      plotBorderWidth: null
      plotShadow: false

    title: null
    tooltip:
      pointFormat: "{series.name}: <b>{point.percentage:.1f}%</b>"

    plotOptions:
      pie:
        allowPointSelect: true
        cursor: "pointer"
        dataLabels:
          enabled: true
          format: "{point.name}"
          # style:
          #   color: (Highcharts.theme and Highcharts.theme.contrastTextColor) or "black"

    series: [
      type: "pie"
      name: "Browser share"
      data: null
    ]

window.generateChartData = (data) ->
  base = $.extend(true, {}, baseChartData)
  base['series'][0]['data'] = data
  return base
