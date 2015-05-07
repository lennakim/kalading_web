#= require ./backbone/models/order
#= require ./backbone/views/service_select
#= require_self

$ ->

  if $(".second").length >= 1
    service_select = new App.Views.ServiceSelect

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
  	$('.first .items').addClass('hide').eq(0).removeClass('hide')
  	$('.select-series,.select-model').removeClass('active')


  #------删除已选车系 或 点击上一步 跳转回选车系------
  $('.selected-series-name .remove').click ->
  	$('.first .items').addClass('hide').eq(1).removeClass('hide')
  	$('.select-model').removeClass('active')


  #------跳转到选配件服务------
  $('.first .model-list').on 'click','li', ->
    car_id = $(@).data("car_id")
    window.location.href = "/orders/new_service_select?car_id=#{car_id}"

  #-----未找到车型------
  $('.undefined-car').click ->
    $('.first,.second,.third').addClass('hide')
    $('.no_car_type').removeClass('hide')


  #-----返回上一步------
  $('.second .prev').click ->
    $('.first').removeClass('hide').next().addClass('hide')

  $('.third .prev').click ->
    $('.second').removeClass('hide').next().addClass('hide')


  #快捷车辆
  $('.cars-list').on 'click','.car-item', ->
    $('.car-item').removeClass('selected')
    $(@).addClass('selected')

# order
  $(".crumbs").on "click", "li", ->
    $(".brand-list").html("")
    letter = $(@).find("a").html()

    generateCarBrand(letter)

  $(".brand-list").on "click", "li", ->
    letter = $(@).data('letter')
    brname = $(@).find("span").html()
    brands = $.jStorage.get("auto-#{letter}")

    brand = _.where(brands, {name: brname})
    auto_models = brand[0]['auto_models']
    generateCarModel(auto_models)

  $(".series-list").on "click", "li", ->
    model_id = $(@).data('model_id')

    $.ajax({
        method: "GET",
        url : "#{API_Domain}#{V2}/auto_models/#{model_id}.json",
        beforeSend: ->
          $('.tips').removeClass('hide')
        ,
        complete: ->
          $('.tips').addClass('hide')
        ,
        success: (data)->
          submodels = data['data']
          generateCarSubModel(submodels)
      })

  unless $.jStorage.get("autos")?
    $.get ("#{API_Domain}#{V2}/autos.json"), (data)->
      console.log("load autos data")
      $.jStorage.set("autos", data['data'], {TTL: 1000*60*60*24*10}) #本地存储
      generateCarIndex($.jStorage.get("autos"))
  else
    generateCarIndex($.jStorage.get("autos"))

  #######################new_service_select################

  #-----服务选项切换------
  $('.service-items li:first-child').addClass('active')

generateCarSubModel = (submodels)->
  $("ul.model-list").html("")
  _.each submodels, (submodel)->
    _.each submodel['submodels'], (sub)->
      $("ul.model-list").append("<li data-car_id=#{sub['id']} class='cursor'>#{sub['year_range']} - #{sub['engine_displacement']}</li>")

generateCarModel = (models)->
  $("ul.series-list").html("")
  _.each models, (model)->
    $("ul.series-list").append("<li data-model_id='#{model['id']}' class='cursor'>#{model['name']}</li>")

generateCarIndex = (autos)->
  _.each autos, (auto)->
    $.jStorage.set("auto-#{auto['initial']}", auto['autos']) #将单条 数据存储
    $("ul.crumbs").append("<li class='cursor'><a href='javascript:;'>#{auto['initial']}</a></li>")

generateCarBrand = (letter) ->
  brands = $.jStorage.get("auto-#{letter}")
  _.each brands, (brand)->
    str = "<li data-letter=#{letter} class='cursor'><img src='#{brand['logo']}'/> <span>#{brand['name']}</span></li>"
    $("ul.brand-list").append(str)
