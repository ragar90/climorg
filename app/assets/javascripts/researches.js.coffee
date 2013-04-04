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
      $("#questions-control").html("")
      params = { "dimensions" : $("#research_dimension_ids").val(), "research_id" : $("#research_id").val() }
      params = jQuery.param(params)
      $("#questions-control").load("/questions?"+ params)
      return true

  $("#research_question_ids").multiselect
    buttonClass: "btn"
    buttonWidth: "auto"
    buttonContainer: "<div class=\"btn-group\" />"
    maxHeight: 150
    buttonText: multiselect_options_text

  $("#research_demographic_variable_ids").multiselect
    buttonClass: "btn"
    buttonWidth: "auto"
    buttonContainer: "<div class=\"btn-group\" />"
    maxHeight: 150
    buttonText: multiselect_options_text

	$("#modalView").on "hidden", ->
		$(@).html("")
	$(".new_setting_link").live "click", (e) ->
		remote_url = $(@).attr("href")
		$("#modalView").load(remote_url)
		$("#modalView").modal
		$("#modalView").modal("show")
		e.preventDefault()

	$(".modal_form").live "ajax:success", (evt, data, status, xhr) -> 
    errors = data["errors"]
    if errors isnt `undefined` or errors?
      display_errors(errors)
    else
      console.log "before setting new options"
      add_option_to_select(data.class, data.value,data.display_value)
      $("#modalView").modal("hide")
  $("#submit_modal_form_btn").live "click", (e) ->
    set_display_values()
    $(".modal_form").trigger("submit.rails");
    e.preventDefault()
  
  $("#cancel_modal_form_btn").live "click", (e) ->
    $("#modalView").modal('hide')
    e.preventDefault()