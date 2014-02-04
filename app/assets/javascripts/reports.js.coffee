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

	$("#report_demographic_variable_ids").on "change", ->
		var_id = $(@).val()
		$(".demographic-query-value").css("display","none")
		$(".demographic-query-value").removeClass("value-selected")
		type_field = $(@).data("variable-types")[var_id][0]
		$("#report_query_variable_type").val(type_field)
		$("."+type_field+"-field").css("display","block")
		$("."+type_field+"-field").addClass("value-selected")

	$("#new_report").on "submit", ->
		value = $(".demographic-query-value.value-selected").val()
		$("#report_query_condition_value").val(value);
