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
    jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage']

  wx.ready ->
    alert 'ready!'

  wx.error (res) ->
    alert 'error!'
    alert res

  wx.checkJsApi
  jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage']
  success: (res) ->
    alert res
    alert '可以用 onMenuShareTimeline, onMenuShareAppMessage'

  wx.onMenuShareTimeline
    title: '病毒别点', # 分享标题
    link: '', # 分享链接
    imgUrl: '', # 分享图标
    success: ->
      alert '分享了'
      $('body').css('background', 'black')
    cancel: ->
      alert '取消了'

  wx.onMenuShareAppMessage
    title: '病毒别点'
    desc: '病毒别点 desc ..'
    link: ''
    imgUrl: ''
    type: ''
    dataUrl: ''
    success: ->
      alert '分享给朋友成功了'
    cancel: ->
      alert '取消分享给朋友'
