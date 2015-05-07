#= require jquery

#= require jssor
#= require jssor.slider
#= require slider

#= require jquery.turbolinks
#= require turbolinks
#= require jquery_ujs
#= require jquery.chained.remote.min
#= require jquery.form
#= require jquery.validate.min
#= require jquery.cookie
#= require picker
#= require legacy
#= require picker.date
#= require picker.time
#= require bootstrap-sprockets
#= require URI
#= require nprogress
#= require nprogress-turbolinks

#= require new/home
#= require new/orders

$ ->
  $('.kld-header-link').on 'mouseenter','li', ->
    $(@).addClass('selected').siblings().removeClass('selected')
    #$('.sub').stop().stop().animate({'height':'0'})
    $('.selected').find('.sub').stop().animate({'height':'100px'},500)
    
    $('.kld-header-wrap').addClass('toggle')
    $('.logo').addClass('hide')
    $('.logored').removeClass('hide')

  $('.sub').mouseleave ->
    $(@).stop().animate({'height':'0'})
    $('.kld-header-wrap').animate({'':''},500, ->
    	$(@).removeClass('toggle')
	    $('.logo').removeClass('hide')
	    $('.logored').addClass('hide')
    )


  $('.product').on 'mouseover','li', ->
    $(@).find('.key,.pic2').removeClass('hide')
    $(@).find('.pic1').addClass('hide')
    
  $('.product').on 'mouseout','li', ->
    $(@).find('.key,.pic2').addClass('hide')
    $(@).find('.pic1').removeClass('hide')

    
