#= require activity/activity
#= require jquery.cookie

$ ->
  $('.title1').animate {'left':'0'}, 500, ->
    $('.title2').animate({'left':'0'},500)

  wx.ready ->

    alert 'go'

    wx.onMenuShareTimeline
      title: '九块九限时抢'
      desc: '每天200张！戳进来抢！'

    wx.onMenuShareAppMessage
      title: '九块九限时抢'
      desc: '每天200张！戳进来抢！'

  wx.error (res) ->
    alert '出错啦! 请刷新重试~'

  #$('.closebtn, .share_button').click ->
    #hideMessage()

  #$('.bac').css({'height':$(window).height()})

  # signature = $("#data").data('signature')
  # timestamp = $("#data").data('timestamp')
  # nonceStr = $("#data").data('noncestr')
  # appId = $("#data").data('appid')
  # thumbnail = $("#data").data('thumbnail')
  # link = $("#data").data('url')
  # sharable = false
  # shared = $.cookie('shared')

  # wx.config
  #   appId: appId
  #   timestamp: timestamp
  #   nonceStr: nonceStr
  #   signature: signature
  #   jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage']

  #showRedPacket = ->
    #$('.active, .rule, .form-con').addClass('hidden')
    #$('.discount-con').removeClass('hidden')

  #showMessage = ->
    #$('.point, .msg, .bac').removeClass('hidden')
    #$('body').css({'overflow':'hidden'})

  #hideMessage = ->
    #$('.point, .msg,.bac').addClass('hidden')

    #$('body').css({'overflow': 'auto'})

  # if shared
  #   showRedPacket()


  #hideMessage()
  #showRedPacket()

  #
  # $('#get_code').click ->
  #   phone_num = $('#phone_num').val()
  #   $(this).addClass('disable').attr('disabled','disabled')
  #   seconds = 60
  #
  #   if phone_num == ''
  #     alert('请输入手机号')
  #     $('.get_code').removeClass('disable').removeAttr('disabled')
  #   else
  #     $.ajax
  #       type: 'POST',
  #       url: '/phones/send_verification_code',
  #       data: {phone_num: phone_num},
  #       success: (data) ->
  #         if data.success
  #           timer = setInterval ->
  #             if seconds > 0
  #               seconds -= 1
  #               $('.get_code').text(seconds+'秒后重新获取')
  #             if seconds == 0
  #               $('.get_code').removeClass('disable').removeAttr('disabled').text('重新获取')
  #               clearInterval(timer)
  #           , 1000
  #
  #         else
  #           alert('请输入正确手机号')
  #           $('.get_code').removeClass('disable').removeAttr('disabled')
  #
  # $("#next_button").on "click", ->
  #   $("#next_button").addClass('disable').attr('disabled','disabled')
  #   phone_num = $("#phone_num").val()
  #   verification_code = $("#verification_code").val()
  #
  #   $.post "/phones", { phone_num: phone_num, code: verification_code }, (data) ->
  #     $("#next_button").removeClass('disable').attr('disabled', false)
  #     if data.success == true
  #       sharable = true
  #       showMessage()
  #     else
  #       alert data.msg
