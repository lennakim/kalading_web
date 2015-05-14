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
#= require gauge

#= require jstorage
#= require jquery.flexslider-min
#= require jquery.easing.min

#= require underscore
#= require backbone
#= require backbone_rails_sync
#= require backbone_datalink
#= modernizr.custom.86080

#= require new/home
#= require new/orders
#= require users

window.API_Domain = gon.global.server_uri
window.V2 = gon.global.v2

$ ->

  $("#wechat_qrcode").on 'click', (e) ->
    $("#wechat_modal").modal()

  #header nav address
  $('nav .address a').click ->
    $("#select_city_modal").modal()

  if !$.cookie('set_city_manually')
    $("#select_city_modal").modal()

  $("#login_btn").click ->
    $("#login_modal").modal()

  $("#change_city").on "click", (e) ->
    e.stopPropagation()
    e.preventDefault()
    id = $('.cities label.active input').val()
    $.post("/cities/#{ id }/set")

  $('.header .kld-header-link').on 'mouseover','li', ->
    $(@).addClass('selected').siblings().removeClass('selected')
  $('.header .kld-header-link').on 'mouseleave','li', ->
    $(@).removeClass('selected')

  $('.products').on 'mouseenter', ->
    $('.header .kld-header-wrap').addClass('toggle')
    $(@).find('.sub').stop().animate({'height':'100px'},500)

    $('.header .logo').addClass('hide')
    $('.logored').removeClass('hide')
    $('.slogan1').addClass('hide')
    $('.slogan2').removeClass('hide')

  $('.products').on 'mouseleave', ->
    $(@).find('.sub').stop().animate({'height':'0'},500, ->
      $('.header .kld-header-wrap').removeClass('toggle')
      $('.header .logo').removeClass('hide')
      $('.logored').addClass('hide')
      $('.slogan1').removeClass('hide')
      $('.slogan2').addClass('hide')
    )

  $('.active .sub2').removeClass('hide')

  # $('.sub').on 'mouseleave', ->
  #   $(@).stop().animate({'height':'0'},500, ->
  #     $(@).removeClass('toggle')
  #   )


  $('.product').on 'mouseover','li', ->
    $(@).find('.key,.pic2').removeClass('hide')
    $(@).find('.pic1').addClass('hide')

  $('.product').on 'mouseout','li', ->
    $(@).find('.key,.pic2').addClass('hide')
    $(@).find('.pic1').removeClass('hide')

  # 短信验证码
  if $("#login_modal").length > 0

    $('.get_code').click ->
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

  if $('.maintain-report').length > 0
    opts =
      lines: 12
      angle: 0.21
      lineWidth: 0.06
      limitMax: 'false'
      colorStart: '#FAB671'
      colorStop: '#EB613C'
      strokeColor: '#fff7f0'
      generateGradient: true

    target = document.getElementById('chart')
    gauge = new Donut(target).setOptions(opts)
    gauge.maxValue = 100
    gauge.animationSpeed = 32
    score = $('#chart').data('data')
    gauge.set(score)
