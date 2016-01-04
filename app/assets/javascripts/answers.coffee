# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    answer_id = $(this).data('answerId')
    $('form#edit-answer-'+answer_id).show()

  $(document).ajaxError (e, xhr, settings) ->
    if xhr.status == 401
      $('#flashes').html("<div class='alert alert-warning'>#{ xhr.responseText }</div>")
      # flash[:notice] = xhr.responseText
      window.location.replace('/users/sign_in')

  #// $(document).bind 'ajax:error', (event, jqXHR, ajaxSettings, thrownError) ->
  #//   if jqXHR.status == 401
  #//     window.location.replace('/users/sign_in')
  #//     $('#flashes').html("<div class='alert alert-warning'>You need to sign in.</div>")

