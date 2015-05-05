$ ->

  #------选车型---------

  #------首字母搜索------
  $('.first .crumbs,.first .brand').on 'click','li', ->
  	$(@).addClass('active').siblings().removeClass('active')

  #------跳转到选 车系-----
  $('.first .brand-list').on 'click','li', ->
  	#已选择的车型tag
  	brand_name = $(@).text()
  	$('.selected-name').removeClass('hide').find('.name').text(brand_name)
  	#选择车系标签
  	$('.select-series').addClass('active')
  	#显示选择车系 隐藏选择品牌
  	$('.first .maintain-items .items').eq(0).addClass('hide').next().removeClass('hide')

  #------跳转到选 排量------
  $('.first .series-list').on 'click','li', ->
  	#已选择的车系tag
  	series_name = $(@).text()
  	$('.selected-series').removeClass('hide').find('.series').text(series_name)
  	#选择排量标签
  	$('.select-model').addClass('active')
  	#显示选择排量 隐藏其他两个
  	$('.first .maintain-items .items').addClass('hide').eq(2).removeClass('hide')


  #------删除已选品牌 跳转回选品牌------
  $('.selected-name .remove').click ->
  	$('.items').addClass('hide').eq(0).removeClass('hide')
  	$('.select-series,.select-model').removeClass('active')

  #------删除已选车系 跳转回选车系------
  $('.selected-series-name .remove').click ->
  	$('.first .items').addClass('hide').eq(1).removeClass('hide')
  	$('.select-model').removeClass('active')

  
  #------跳转到选服务------
  $('.first .model-list').on 'click','li', ->
    $('.first').addClass('hide')
    $('.second').removeClass('hide')

  #------选服务页面 点击下一步 显示下单页面------
  $('.second .next').click ->
    $('.second').addClass('hide')
    $('.third').removeClass('hide')





