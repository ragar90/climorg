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
jQuery ->
	$(".datetime_select").datepicker(format: "dd/mm/yyyy")
	$(".multiselect-container select").multiSelect()
	$("#modalView").on "hidden", ->
		$(@).html("")
	$(".new_setting_link").on "click", (e) ->
		remote_url = $(@).attr("href")
		$("#modalView").load(remote_url)
		$("#modalView").modal
		$("#modalView").modal("show")
		e.preventDefault()
	$(".demographic_modal_form").live "ajax:success", (evt, data, status, xhr) -> 
	  errors = data["errors"]
	  if errors isnt `undefined` or errors?
	  	display_errors(errors)
	  else
			name = data["name"]
			id = data["id"] 
			select_option = "<option value='"+id+"'>"+name+"</option>"
			$("#research_demographic_variable_ids").html(select_option)
			$("#ms-research_demographic_variable_ids").remove()
			$("#demographic_ms_container select").multiSelect()
			$("#modalView").modal('toggle')
	$("#submit_modal_form_btn").live "click", (e) ->
    set_display_values()
    $("#new_demographic_variable").trigger("submit.rails");
    e.preventDefault()
  $("#cancel_modal_form_btn").live "click", (e) ->
    $("#modalView").modal('hide')
    e.preventDefault()