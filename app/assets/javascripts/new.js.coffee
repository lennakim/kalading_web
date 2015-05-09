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

#= require new/home
#= require new/orders

window.API_Domain = gon.global.server_uri
window.V2 = gon.global.v2

$ ->

  # select address
  $(".addresses .add > a").on "click", (e)->
    console.log 1
    e.stopPropagation()
    e.preventDefault()
    $("#add_address_modal").modal()

  # select service address
  $("#service_districts").chained("#service_cities")
  $('#service_districts').on 'change', (e) ->
    city = $("#service_cities").val()
    district = $("#service_districts").val()
    ac.setInputValue "#{city}#{district}"

  # add address modal
  $("#add_address_modal").on "click", ".add-address > button", (e) ->
    e.preventDefault()
    e.stopPropagation()
    $(@).addClass('disabled')
    $modal = $(e.delegateTarget)
    city = $modal.find('select.city').val()
    district = $modal.find('select.district').val()

    detail = $modal.find('#address_detail').val()
    if $.trim(detail) != ""
      $.post "/service_addresses", { service_address: { city: city, district: district, detail: detail } }

    else
      $modal.find("#address_detail").closest(".form-group").addClass("has-error")

  $("#add_address_modal").on "hidden.bs.modal", ->
    $(@).find(".add-address > button").removeClass('disabled')

  $("#address_detail").on "keyup", (e) ->
    $button = $("#add_address_modal .add-address > button")
    if e.keyCode == 13 && !$button.hasClass('disabled')
      $button.trigger "click"

