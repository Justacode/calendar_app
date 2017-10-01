# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#forever').change ->
  ischecked = $(this).is(':checked')
  if ischecked
    $('#finish_date').fadeOut 200
  else
  	$('#finish_date').fadeIn 200
  return