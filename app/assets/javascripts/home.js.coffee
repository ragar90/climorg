# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $(".command.minimize").on "click", (e) ->
    e.preventDefault();
    $this = $(@);
    $collapse = $this.closest('.collapse-group').find('.collapse');
    $collapse.collapse('toggle');