#= require activity/activity

$ ->
  console.log 'papago'


  $('.title1').animate {'left':'0'}, 500, ->
    $('.title2').animate({'left':'0'},500)

  $('.closebtn,.share_button').click ->
    $('.msg').addClass('hidden')
    $('.msg,.bac').addClass('hidden')
    $('body').css({'overflow':'auto'})
  
  $('.bac').css({'height':$(window).height()})


  #下一步（有手机号和验证码的时候 弹出分享提示框）
  $('.next_button').click ->
    if $('#phone_num').val() != ''
      if $('#verification_code').val() != ''
        $('.msg,.bac').removeClass('hidden')
        $('body').css({'overflow':'hidden'})
      else
        alert('请您先获取验证码！')
    else
      alert('请您先填写手机号！')
      

    

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


  signature = $("#data").data('signature')
  timestamp = $("#data").data('timestamp')
  nonceStr = $("#data").data('noncestr')
  appId = $("#data").data('appid')

  wx.config
    debug: true
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
        alert '分享了'
        $('.active,.rule,.form-con').addClass('hidden')
        $('.discount-con').removeClass('hidden')
      cancel: ->
        alert '取消了'
        $('.msg,.bac').removeClass('hidden');
        $('body').css({'overflow':'hidden'});

    wx.onMenuShareAppMessage
      title: '病毒别点'
      desc: '病毒别点 desc ..'
      link: ''
      imgUrl: ''
      type: ''
      dataUrl: ''
      success: ->
        alert '分享给朋友成功了'
        $('.active,.rule,.form-con').addClass('hidden')
        $('.discount-con').removeClass('hidden')
      cancel: ->
        alert '取消分享给朋友'
        $('.msg,.bac').removeClass('hidden');
        $('body').css({'overflow':'hidden'});

  wx.error (res) ->
    alert 'error!'
    alert res

