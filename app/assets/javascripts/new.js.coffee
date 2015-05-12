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

#= require jstorage

#= require underscore
#= require backbone
#= require backbone_rails_sync
#= require backbone_datalink
#= modernizr.custom.86080

#= require new/home
#= require new/orders

window.API_Domain = gon.global.server_uri
window.V2 = gon.global.v2

$ ->

  $('.header .kld-header-link').on 'mouseover','li', ->
  	$(@).addClass('selected').siblings().removeClass('selected')
  $('.header .kld-header-link').on 'mouseleave','li', ->
  	$(@).removeClass('selected')

  $('.header .products').on 'mouseenter', ->
    $('.header .kld-header-wrap').addClass('toggle')
    $(@).find('.sub').stop().animate({'height':'100px'},500)
    
    $('.logo').addClass('hide')
    $('.logored').removeClass('hide')
    $('.slogan1').addClass('hide')
    $('.slogan2').removeClass('hide')


  $('.header .products').mouseleave ->
    $(@).find('.sub').stop().animate({'height':'0'},500, ->
      $('.header .kld-header-wrap').removeClass('toggle')
    )

  $('.header-others .products,.header-others .service,.header-others .team').on 'mouseenter', ->
    $(@).find('.sub2').removeClass('hide')

  $('.header-others .products,.header-others .service,.header-others .team').on 'mouseleave', ->
    $(@).find('.sub2').addClass('hide')

  $('.header .sub').mouseleave ->
    $(@).stop().animate({'height':'0'},500, ->
      $(@).removeClass('toggle')
    )
    $('.kld-header-wrap').animate({'':''},500, ->
      $('.logo').removeClass('hide')
      $('.logored').addClass('hide')
      $('.slogan1').removeClass('hide')
      $('.slogan2').addClass('hide')
    )


  $('.product').on 'mouseover','li', ->
    $(@).find('.key,.pic2').removeClass('hide')
    $(@).find('.pic1').addClass('hide')
    
  $('.product').on 'mouseout','li', ->
    $(@).find('.key,.pic2').addClass('hide')
    $(@).find('.pic1').removeClass('hide')

