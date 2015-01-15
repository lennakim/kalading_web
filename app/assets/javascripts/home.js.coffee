$ ->
  $("#login_btn").on "click", (e) ->
    e.preventDefault()
    e.stopPropagation()

    $('#login_modal').modal()

  if $('.home-page').length > 0
    $('.home-page').css({'min-Width':'1280px'}).siblings('.navbar,.footer').css({'min-Width':'1280px'}).find('.container').css({'min-Width':'1170px'})
    $('.home-page .container').css({'min-Width':'1170px'})

    $('.carousel').carousel()

    $('.maintain-item').on 'mouseover','dl', ->
      $(this).find('img').addClass('filter')
      $(this).find('.bac').addClass('showbac')
      $(this).find('.con').addClass('showcon')
    $('.maintain-item').on 'mouseout','dl', ->
      $(this).find('img').removeClass('filter')
      $(this).find('.bac').removeClass('showbac')
      $(this).find('.con').removeClass('showcon')

  if $('.home-phone').length > 0
    $(window).scroll ->
      if $(window).scrollTop()>200
        $("#totop").fadeIn(1000)
      else
        $("#totop").fadeOut(1000)
    
    $("#totop").click ->
        $('body,html').animate({scrollTop:0},1000)
        return false



