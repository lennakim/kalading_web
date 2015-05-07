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
  $('.kld-header-link').on 'mouseover','li', ->
    $(@).addClass('selected').siblings().removeClass('selected')
    $('.sub').addClass('hide')
    $('.selected').find('.sub').removeClass('hide')
