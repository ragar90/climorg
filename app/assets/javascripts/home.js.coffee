# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $(".command.minimize").on "click", (e) ->
    e.preventDefault();
    $this = $(@);
    $collapse = $this.closest('.collapse-group').find('.collapse');
    $collapse.collapse('toggle');

  $(".download-chart-btn").on "click", (e)->
    e.preventDefault()
    root_parent = $(@).closest(".data-window")
    chart_container = $(root_parent).children(".window-content").children(".report-chart.chart-copy")[0]
    container_div_name = $(chart_container).attr("name")
    grChartImg.SetImageFormat = {type:'png'}
    grChartImg.DownloadImage(container_div_name)
    
  $.each $(".easypie-chart"), (i,obj) ->
    color = $(obj).data("barcolor")
    $(obj).easyPieChart
      scaleColor: false,
      lineWidth: 15,
      trackColor: "#AFAFAF",
      lineCap: "butt",
      barColor: color