$ ->
  $("#login_btn").on "click", (e) ->
    e.preventDefault()
    e.stopPropagation()

    $('#login_modal').modal()

  if $('.home-page').length > 0

    $('.carousel').carousel()

    $('.maintain-item').on 'mouseover','dl', ->
      $(this).find('img').addClass('filter')
      $(this).find('.bac').removeClass('hidden')
      $(this).find('.con').addClass('show')
    $('.maintain-item').on 'mouseout','dl', ->
      $(this).find('img').removeClass('filter')
      $(this).find('.bac').addClass('hidden')
      $(this).find('.con').removeClass('show')



