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


  if $("#login_modal").length > 0

    $('#get_code').click ->

      phone_num = $('#phone_num').val()
      $(this).addClass('disable').attr('disabled', 'disabled')
      seconds = 60

      if phone_num == ''
        alert('请输入手机号')
        $('.get_code').removeClass('disable').removeAttr('disabled')
      else
        $.ajax
          type: 'POST',
          url: '/phones/send_verification_code',
          data: {phone_num: phone_num},
          success: (data) ->
            if data.success
              timer = setInterval ->
                if seconds > 0
                  seconds -= 1
                  $('.get_code').text(seconds+'秒后重新获取')
                if seconds == 0
                  $('.get_code').removeClass('disable').removeAttr('disabled').text('重新获取')
                  clearInterval(timer)
              , 1000

            else
              alert('请输入正确手机号')
              $('.get_code').removeClass('disable').removeAttr('disabled')

    $("#submit_button").on "click", ->
      $("#submit_button").addClass('disable').attr('disabled','disabled')
      phone_num = $("#phone_num").val()
      verification_code = $("#verification_code").val()

      csrf_token = $("meta[name='csrf-token']").attr('content')
      data = { phone_num: phone_num, code: verification_code, authenticity_token: csrf_token }

      $.form('/sessions', data).submit()

