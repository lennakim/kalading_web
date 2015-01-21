#= require activity/activity

$ ->

  $('.title1').animate {'left':'0'}, 500, ->
    $('.title2').animate({'left':'0'},500)

  $('.closebtn,.share_button').click ->
    $('.msg').addClass('hidden')
    $('.msg,.bac').addClass('hidden')
    $('body').css({'overflow':'auto'})



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

  $('.bac').css({'height':$(window).height()})



  signature = $("#data").data('signature')
  timestamp = $("#data").data('timestamp')
  nonceStr = $("#data").data('noncestr')
  appId = $("#data").data('appid')

  wx.config
    appId: appId
    timestamp: timestamp
    nonceStr: nonceStr
    signature: signature
    jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage']

  wx.ready ->

    wx.onMenuShareTimeline
      title: '病毒别点', # 分享标题
      link: '', # 分享链接
      imgUrl: '', # 分享图标
      success: ->
        $('.active, .rule, .form-con').addClass('hidden')
        $('.discount-con').removeClass('hidden')
      cancel: ->
        $('.msg,.bac'). removeClass('hidden')
        $('body').css({'overflow':'hidden'})

    wx.onMenuShareAppMessage
      title: '病毒别点'
      desc: '病毒别点 desc ..'
      link: ''
      imgUrl: ''
      type: ''
      dataUrl: ''
      success: ->
        $('.active,.rule,.form-con').addClass('hidden')
        $('.discount-con').removeClass('hidden')
      cancel: ->
        $('.msg,.bac').removeClass('hidden')
        $('body').css({'overflow':'hidden'})

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
      if data.success == true

        $("#next_button").removeClass('disable').attr('disabled', false)

        $('.msg,.bac').removeClass('hidden')
        $('body').css({'overflow':'hidden'})
      else
        alert data.msg

