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

    $('.logo').addClass('hide')
    $('.logored').removeClass('hide')
    $('.slogan1').addClass('hide')
    $('.slogan2').removeClass('hide')


  $('.products').on 'mouseleave', ->
    $(@).find('.sub').stop().animate({'height':'0'},500, ->
      $('.header .kld-header-wrap').removeClass('toggle')
    )

  $('.header-others .kld-header-link').on 'mouseover','li', ->
    $('.sub2').addClass('hide')
    $(@).find('.sub2').removeClass('hide')

  # $('.header-others .products,.header-others .service,.header-others .team,.header-others .about').on 'mouseleave', ->
  #   $(@).find('.sub2').addClass('hide')

  $('.sub').on 'mouseleave', ->
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


  # 短信验证码
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
