# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
set_boolean = ->
  bool_val = $("#display_values_boolean_true").val() + "|" + $("#display_values_boolean_false").val()
  $("#demographic_variable_display_values").val bool_val

set_integer = ->
  int_val = "-"
  $("#demographic_variable_display_values").val int_val

set_float = ->
  float_val = "-"
  $("#demographic_variable_display_values").val float_val

set_range = ->
  range_val = $("#display_values_min_range").val() + "-" + $("#display_values_max_range").val()
  $("#demographic_variable_display_values").val range_val

set_hash = ->
  hash_val = $("#display_values_hash").val()
  hash_val = hash_val.substring 0, hash_val.length - 1  if hash_val[hash_val.length - 1] is ","
  $("#demographic_variable_display_values").val hash_val

select_displayable_field = ->
  value = $("#demographic_variable_accepted_value").val()
  $(".admin-dsiplay-values").removeClass "selected"
  $("#" + value + "-display").addClass "selected"

set_display_values = (e) ->
  selected_type = $("#demographic_variable_accepted_value").val()
  switch selected_type
    when "integer" then set_integer()
    when "float" then set_float()
    when "boolean" then set_boolean()
    when "range" then set_range()
    when "hash" then set_hash()
  #console.log $("#demographic_variable_display_values").val()
  #e.preventDefault()

#call hash setter
binders = ->
  $("#new_demographic_variable").on "submit", set_display_values
  $("#edit_demographic_variable").on "submit", set_display_values
  $("#demographic_variable_accepted_value").on "change", select_displayable_field
  
jQuery ->
  binders()

