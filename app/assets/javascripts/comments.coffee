$(document).on "page:change", ->
  $('#comments_link').click (event) ->
    event.preventDefault()
    $('#comments_wrapper').fadeToggle()
    $('#comment_content').focus()