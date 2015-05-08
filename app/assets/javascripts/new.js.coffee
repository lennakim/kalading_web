#= require jquery
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

#= modernizr.custom.86080

#= require new/home
#= require new/orders

$ ->

  $('.kld-header-link').on 'mouseover','li', ->
  	$(@).addClass('selected').siblings().removeClass('selected')
  $('.kld-header-link').on 'mouseleave','li', ->
  	$(@).removeClass('selected')

  $('.products').on 'mouseenter', ->

    $('.kld-header-wrap').addClass('toggle')
    $(@).find('.sub').stop().animate({'height':'100px'},500)
    
    $('.logo').addClass('hide')
    $('.logored').removeClass('hide')

  $('.products').mouseleave ->
    $(@).find('.sub').stop().animate({'height':'0'},500, ->
      $('.kld-header-wrap').removeClass('toggle')
    )


  $('.sub').mouseleave ->
    $(@).stop().animate({'height':'0'},500, ->
      $(@).removeClass('toggle')
    )
    $('.kld-header-wrap').animate({'':''},500, ->
    	
	    $('.logo').removeClass('hide')
	    $('.logored').addClass('hide')
    )


  $('.product').on 'mouseover','li', ->
    $(@).find('.key,.pic2').removeClass('hide')
    $(@).find('.pic1').addClass('hide')
    
  $('.product').on 'mouseout','li', ->
    $(@).find('.key,.pic2').addClass('hide')
    $(@).find('.pic1').removeClass('hide')

    
