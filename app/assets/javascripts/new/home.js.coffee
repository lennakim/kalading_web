$ ->
  $('.product').on 'mouseover','li', ->
    $(@).find('.key,.pic2').removeClass('hide')
    $(@).find('.pic1').addClass('hide')
    
  $('.product').on 'mouseout','li', ->
    $(@).find('.key,.pic2').addClass('hide')
    $(@).find('.pic1').removeClass('hide')