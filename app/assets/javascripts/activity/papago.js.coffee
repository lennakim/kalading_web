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

  $('.next_button').click ->
    $('.msg,.bac').removeClass('hidden')
    $('body').css({'overflow':'hidden'})


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

