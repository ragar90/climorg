# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@display_errors = (errors) ->
  header_msg = "No se pudo guardar este registro debido a uno o mas errores"
  alert_html = "<div class='alert alert-error' style='display:none;><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button><h4 class='errors-header'></h4><ul class='errors-list'></ul></div>"
  $("#modal_errors").html(alert_html)
  msg_list = ""
  $("#modal_errors .errors-header").html(header_msg)
  for error of errors
    msg_list += "<li>" + error + ": " + errors[error][0]+"</li>"
  $("#modal_errors .errors-list").html(msg_list)
  $("#modal_errors .alert").show("slow")

@load_dimension_values = (element) ->
  values = []
  if $(element).length > 1
    $(element).each( (i,e) -> 
      values.push($(e).val()) )
  $(element).html("")
  d = $("#research_dimension_ids option[selected='selected']")
  options =  ""
  i = 0
  while i < d.length
    options = options + "<option value=" + $(d[i]).val() + ">" + $(d[i]).text() + "</option>"
    i++
  $(element).append(options)
  $(element).each( (i,e) -> 
      $(e).val(values[i]) )
  return true

@add_option_to_select = (select, value, display_value) =>
  select_option = "<option value='"+value+"'>"+display_value+"</option>"
  $("#research_"+select+"_ids").append(select_option)
  $("#research_"+select+"_ids").multiselect('rebuild')

@multiselect_options_text = (options) ->
  if options.length is 0
    "None selected <b class=\"caret\"></b>"
  else if options.length >= 3
    options.length + " selected  <b class=\"caret\"></b>"
  else
    selected = ""
    options.each ->
      selected += $(this).text() + ", "
    selected.substr(0, selected.length - 2) + " <b class=\"caret\"></b>"
jQuery ->
  $('.research_form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.question-form').hide()
    event.preventDefault()

  $('.research_form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    load_dimension_values($(".dq_select").last())
    event.preventDefault()

  $(".datetime_select").datepicker(format: "dd/mm/yyyy")

  $("#research_dimension_ids").multiselect
    buttonClass: "btn"
    buttonWidth: "auto"
    buttonContainer: "<div class=\"btn-group\" />"
    maxHeight: 150
    buttonText: multiselect_options_text
    onChange: (element, checked)->
      load_dimension_values(".dq_select")

  $("#research_demographic_variable_ids").multiselect
    buttonClass: "btn"
    buttonWidth: "auto"
    buttonContainer: "<div class=\"btn-group\" />"
    maxHeight: 150
    buttonText: multiselect_options_text

  $("#modalView").on "hidden", ->
    $(@).html("")
  $(document).on "click",".new_setting_link", (e) ->
    remote_url = $(@).attr("href")
    $("#modalView").load(remote_url)
    $("#modalView").modal
    $("#modalView").modal("show")
    $("a[data-toggle=tooltip]").tooltip(placement:"right")
    e.preventDefault()

  $(document).on "ajax:success", ".modal_form", (evt, data, status, xhr) -> 
    errors = data["errors"]
    if errors isnt `undefined` or errors?
      display_errors(errors)
    else
      console.log "before setting new options"
      add_option_to_select(data.class, data.value,data.display_value)
      $("#modalView").modal("hide")

  $(document).on "click","#submit_modal_form_btn", (e) ->
    set_display_values()
    $(".modal_form").trigger("submit.rails");
    e.preventDefault()

  $(document).on "click","#cancel_modal_form_btn", (e) ->
    $("#modalView").modal('hide')
    e.preventDefault()

  $(document).on("click", ".download-chart-btn", (e) ->
    chart_id = $(@).data("chart")
    saveAsImg(document.getElementById(chart_id));
    e.preventDefaults();
  )