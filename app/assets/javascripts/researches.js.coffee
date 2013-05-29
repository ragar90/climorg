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

@add_option_to_select = (select, value, display_value) =>
  select_option = "<option value='"+value+"'>"+display_value+"</option>"
  $("#research_"+select+"_ids").append(select_option)
  $("#research_"+select+"_ids").multiselect('rebuild')
  if select is "dimension"
    $(".dq_select").append(select_option)

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
  $(".datetime_select").datepicker(format: "dd/mm/yyyy")

  $("#research_dimension_ids").multiselect
    buttonClass: "btn"
    buttonWidth: "auto"
    buttonContainer: "<div class=\"btn-group\" />"
    maxHeight: 150
    buttonText: multiselect_options_text
    onChange: (element, checked)->
      $(".dq_select").html("")
      d = $("#research_dimension_ids option[selected='selected']")
      options =  ""
      i = 0
      while i < d.length
        options = options + "<option value=" + $(d[i]).val() + ">" + $(d[i]).text() + "</option>"
        i++
      $(".dq_select").append(options)
      return true


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