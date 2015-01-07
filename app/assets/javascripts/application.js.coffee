#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require turbolinks
#= require jquery.chained.remote.min
#= require jquery.form
#= require jquery.validate.min
#= require picker
#= require legacy
#= require picker.date
#= require picker.time
#= require bootstrap-sprockets
#
#= require home
#= require users
#
#= require_self

window.Kalading =
  Views: {}
  Models: {}

$ ->

  $('#car_style').chained('#car_type,#car_name')
  $('#car_type').chained('#car_name')

  $(".addresses .add").on "click", (e)->
    e.stopPropagation()
    e.preventDefault()

    $("#add_address_modal").modal()


  # add address
  $('.address-list').on 'mouseover','.address-item', ->
    _close = $(this).find('.close')
    if $(this).hasClass('selected-item')
      _close.addClass('hidden')
      $(this).css({'borderColor':'#ffd4a9'})
    else
      _close.removeClass('hidden')
      $(this).css({'borderColor':'#ffd4a9'})

  $('.address-list').on 'mouseout','.address-item', ->
    _close = $(this).find('.close')
    if $(this).hasClass('selected-item')
      _close.addClass('hidden')
      $(this).css({'borderColor':'#ef7337'})
    else
      _close.addClass('hidden')
      $(this).css({'borderColor':'#f1f1f1'})

  $('.address-list').on 'click','.close', ->
    $(this).parent('.address-item').remove()

  $('.address-list').on 'click','.address-item', ->
    _close = $(this).find('.close')
    _selected = $(this).find('.selected')

    $(this).addClass('selected-item').css({'borderColor':'#ef7337'}).siblings().removeClass('selected-item').css({'borderColor':'#f1f1f1'})

    _selected.removeClass('hidden').parent().siblings().find('.selected').addClass('hidden')

    _close.addClass('hidden')

    showTitle()

  showTitle = ->
    if $('.address-list').children().length != 0
      $('.choice-title').removeClass('hidden')
    else
      $('.choice-title').addClass('hidden')

  $('.add-address').on "click", ->
    city = $('#city_name option:selected').text()
    town = $('#town_name option:selected').text()
    address = $('#address').val()
    $('.address-list').prepend('<dl class="address-item"><dt>'+city+' '+town+'</dt><dd>'+address+'</dd><dd class="close hidden"></dd><dd class="selected hidden"></dd></dl>')

    showTitle()

  # end - add address
