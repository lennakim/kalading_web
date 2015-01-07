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

  # select car
  $('#car_style').chained('#car_type,#car_name')
  $('#car_type').chained('#car_name')


  # select address
  $(".addresses .add").on "click", (e)->
    e.stopPropagation()
    e.preventDefault()

    $("#add_address_modal").modal()

  # add address modal
  $("#add_address_modal").on "click", ".add-address > button", (e) ->
    e.preventDefault()
    e.stopPropagation()
    $(@).addClass('disabled')
    $modal = $(e.delegateTarget)
    city = $modal.find('select.city').val()

    detail = $modal.find('#address_detail').val()
    if $.trim(detail) != ""
      $.post "/service_addresses", { service_address: { city: city, detail: detail } }
    else
      $modal.find("#address_detail").closest(".form-group").addClass("has-error")

  $("#add_address_modal").on "hidden.bs.modal", ->
    $(@).find(".add-address > button").removeClass('disabled')
