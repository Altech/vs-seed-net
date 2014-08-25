
## =========== Video Filtering ============
$ ($) ->
  $('.filter-by-selection select').change ->
    path = window.location.pathname + "?filtering_id=" + $(this).val()
    $('#replaceable').load (path + "&ajax=true")

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
