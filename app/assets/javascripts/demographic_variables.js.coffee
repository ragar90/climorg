# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
set_integer = ->

set_float = ->

set_boolean = ->

set_boolean = ->

set_range = ->

set_hash = ->
	
select_displayable_field = (value) ->
  $(".admin-dsiplay-values").removeClass "selected"
  $("#" + value + "-display").addClass "selected"
set_display_values = ->
  selected_type = $("#demographic_variable_accepted_value").val()
  switch selected_type
    when "integer" then set_integer()
    when "float" then set_float()
    when "boolean" then set_boolean()
    when "range" then set_range()
    when "hash" then set_hash()

#call hash setter
binders = ->
  $("#new_demographic_variable").on "submit", set_display_values()
  $("#demographic_variable_accepted_value").on "change", select_displayable_field($(this).val())

$(document).on "ready", binders()
