#= require activity/activity

$ ->
  console.log 'papago'

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
    jsApiList: ['onMenuShareTimeline']

  wx.ready ->
    alert 'ready!'

  wx.error (res) ->
    alert 'error!'
    alert res

  wx.onMenuShareTimeline
    title: '', # 分享标题
    link: '', # 分享链接
    imgUrl: '', # 分享图标
    success: ->
      alert '分享了'
      $('body').css('background', 'black')
    cancel: ->
      alert '取消了'
