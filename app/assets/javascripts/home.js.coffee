$ ->

  $('.carousel').carousel()

  $('.maintain-item').on 'mouseover','dl', ->
    $(this).find('img').addClass('filter')
    $(this).find('.bac').removeClass('hidden')
    $(this).find('.con').addClass('show')
    $(this).find('.item-title').addClass('show-title')
  $('.maintain-item').on 'mouseout','dl', ->
    $(this).find('img').removeClass('filter')
    $(this).find('.bac').addClass('hidden')
    $(this).find('.con').removeClass('show')
    $(this).find('.item-title').removeClass('show-title')
	
