# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	$(".parrameter-switch").on "click", ->
		parameter_container = $(@).data("toggle");
		display_value = $(parameter_container).css("display");
		if display_value is "none"
			$(parameter_container).css("display", "block");
		else
			$(parameter_container+ " .demographic-query-value").css("display", "none");
			$(parameter_container).css("display", "none");
			$(parameter_container+ " select").val("");
			$(parameter_container+ " input[type=hidden]").val("");

	$("#report_demographic_variable_ids").on "change", ->
		var_id = $(@).val()
		$(".demographic-query-value").css("display","none")
		$(".demographic-query-value").removeClass("value-selected")
		type_field = $(@).data("variable-types")[var_id][0]
		$("#report_query_variable_type").val(type_field)
		$("#report_query_condition_value_label").val($(@).children("option:selected").text())
		$("."+type_field+"-field").css("display","block")
		$("."+type_field+"-field").addClass("value-selected")

	$("select.demographic-query-value").on "change", ->
		console.log("bolean or hash")
		value = $(@).val()
		$("#report_query_condition_value").val(value);

	$("input[type='number'].integer-field, input[type='number'].float-field").on "focusout", ->
		console.log("float-field or integer-field")
		value = $(@).val()
		$("#report_query_condition_value").val(value);

	$("input[type='number'].range-field").on "focusout", ->
		console.log("range-field")
		value = ""
		this_value = $(@).val()
		brother = $(@).data("brother")
		brother_value = $(brother).val()
		if brother_value is ""
			return
		if $(@).data("range-value-type") is "min_val"
			value = this_value+"-"+brother_value
		else
			value = brother_value+"-"+this_value
		$("#report_query_condition_value").val(value);
