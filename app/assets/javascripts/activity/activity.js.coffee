#= require jquery
#= require jquery_ujs
#= require jquery.validate.min
#= require bootstrap-sprockets

#= require wechat

@share_to_weixin = ->

  $('.share-weixin').animate({'top':'0'}, 200)
  $('.bac').addClass('hidden')
