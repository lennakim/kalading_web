#= require activity/activity

$ ->
  $('.title1').animate {'left':'0'}, 500, ->
    $('.title2').animate({'left':'0'},500)

  $('.closebtn, .share_button').click ->
    hideMessage()

  $('.bac').css({'height':$(window).height()})

  signature = $("#data").data('signature')
  timestamp = $("#data").data('timestamp')
  nonceStr = $("#data").data('noncestr')
  appId = $("#data").data('appid')
  thumbnail = $("#data").data('thumbnail')
  link = $("#data").data('url')
  sharable = false

  wx.config
    appId: appId
    timestamp: timestamp
    nonceStr: nonceStr
    signature: signature
    jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage']

  showRedPacket = ->
    $('.active, .rule, .form-con').addClass('hidden')
    $('.discount-con').removeClass('hidden')

  showMessage = ->
    $('.msg, .bac').removeClass('hidden')
    $('body').css({'overflow':'hidden'})

  hideMessage = ->
    $('.msg').addClass('hidden')
    $('.msg,.bac').addClass('hidden')

    $('body').css({'overflow': 'auto'})

  wx.ready ->

    wx.onMenuShareTimeline
      title: '爱车新年无霾劵！每天500张，戳进来抢！'
      link: link
      imgUrl: thumbnail
      desc: '预订卡拉丁【PM2.5空调滤芯】直接抵扣原价，仅需支付9块9，并有机会享每年三次免费滤芯更换哦！'
      success: ->
        if sharable
          hideMessage()
          showRedPacket()
      cancel: ->
        if sharable
          showMessage()

    wx.onMenuShareAppMessage
      title: '爱车新年无霾劵！每天500张，戳进来抢！'
      desc: '预订卡拉丁【PM2.5空调滤芯】直接抵扣原价，仅需支付9块9，并有机会享每年三次免费滤芯更换哦！'
      link: link
      imgUrl: thumbnail
      type: ''
      dataUrl: ''
      success: ->
        if sharable
          hideMessage()
          showRedPacket()
      cancel: ->
        if sharable
          showMessage()

  wx.error (res) ->
    alert '出错啦! 请刷新重试~'

  $('#get_code').click ->
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

  $("#next_button").on "click", ->
    $("#next_button").addClass('disable').attr('disabled','disabled')
    phone_num = $("#phone_num").val()
    verification_code = $("#verification_code").val()

    $.post "/phones", { phone_num: phone_num, code: verification_code }, (data) ->
      $("#next_button").removeClass('disable').attr('disabled', false)
      if data.success == true
        sharable = true
        showMessage()
      else
        alert data.msg
