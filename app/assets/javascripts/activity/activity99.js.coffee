#= require_self

$ ->
  if $('.activity99').length > 0
    $("#submit_button").on "click", ->
      $("#submit_button").addClass('disable').attr('disabled','disabled');
      phone_num = $("#phone_num").val()
      verification_code = $("#verification_code").val()
      car_license_num = $("#car_license_num").val()

      $.post "/phones", { phone_num: phone_num, code: verification_code, car_license_num: car_license_num }, (data) ->
        if data.success == true
          $("html,body").animate({scrollTop:0},1000);
          $('.form-box').animate({'bottom':'-250px'},50).hide()
          $('.order-btn').text('约好了，等电话吧~')

          if(typeof WeixinJSBridge == 'undefined')
            $('.bac').addClass('hidden')
            $('.share').animate({'top':'-200'}, 200)

          $('body').on "click", ->
            $('.share').animate({'top':'-200'},200)
            $('.bac').addClass('hidden')
        else
          alert('一定是姿势不对，请再约一次！')


  data = {
    'img': $('.activity99').data('thumbnail'),
    'link': $('.activity99').data('link'),
    'desc': '他们都贴了卡拉丁No 霾 in Car——万名卡粉邀你入伙！',
    'title': '9块9，可以约很多次哦！'
  }

  wechat('timeline', data)
  wechat('friend', data)
  wechat('weibo', data)

  $('.activity99,.bac').height($(window).height())

  $('.order-btn').click ->
    $('.bac').removeClass('hidden')
    $('.form-box').animate({'bottom':'300px'},200)

  $('.form-box input').focus ->
    $("#submit_button").removeClass('disable').removeAttr('disabled')

  $('.get_code').click ->
    phone_num = $('#phone_num').val()
    $(this).addClass('disable').attr('disabled','disabled')
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

