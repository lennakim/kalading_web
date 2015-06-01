class App.Views.CarSelect extends Backbone.View

  el: '.first'

  events:
    "click ul.crumbs > li":      "selectBrandByLetter"
    "click ul.brand-list > li":  "viewBrandName"
    "click ul.series-list > li": "viewSubModelName"
    "click ul.model-list li":  "selectModel" #结构改变 selector改变

  initialize: ->
    unless $.jStorage.get("autos")?
      $.get ("#{API_Domain}#{V2}/two_level_autos.json"), (data)->
        console.log("load autos data")
        $.jStorage.set("autos", data['data'], {TTL: 1000*60*60*24*10})
        generateCarIndex($.jStorage.get("autos"))
    else
      generateCarIndex($.jStorage.get("autos"))
      $.jStorage.flush()

    if $.jStorage.get("auto-A")
      _.defer(_.bind(@viewFirstCar, this))

  render: ->

  viewFirstCar: ->
    $("ul.crumbs > li:first").trigger("click")

  selectModel: (e)=>
    self = $(e.currentTarget)
    self.addClass("active").siblings().removeClass("active")
    car_id = self.data("car_id")
    @$(".next").find("a").attr("car_id", car_id)

  selectBrandByLetter: (e)=>
    $(".brand-list").html("")
    self = $(e.currentTarget)
    letter = self.find("a").html()
    self.addClass('active').siblings().removeClass('active')
    generateCarBrand(letter)

  viewSubModelName: (e)=>
    self = $(e.currentTarget)
    model_id = self.data('model_id')

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

  viewBrandName: (e)=>
    self = $(e.currentTarget)
    brand_name = self.text()
    letter = self.data('letter')
    brname = self.find("span").html()
    $('.selected-name').removeClass('hide').find('.name').text(brand_name)
    #选择车系标签
    $('.select-series').addClass('active')
    #显示选择车系 隐藏选择品牌
    $('.first .maintain-items .items').eq(0).addClass('hide').next().removeClass('hide')

    generateCarModel(letter, brname)

  generateCarSubModel = (submodels)-> #生成子品牌
    $("ul.model-list .no-subname").html("")
    $("ul.model-list .has-subname").html("")

    _.each submodels, (submodel)->
      _.each submodel['submodels'], (sub)->
        eng = sub['engine_displacement']
        subname = sub['name']

        if _.isEmpty(subname)
          if _.isEmpty(eng)
            $("ul.model-list .no-subname").append("<li data-car_id=#{sub['id']} class='cursor'>#{sub['year_range']}</li>")
          else
            $("ul.model-list .no-subname").append("<li data-car_id=#{sub['id']} class='cursor'>#{sub['year_range']} - #{eng}</li>")
        else
          str = "<div>#{subname}</div>"

          if _.isEmpty(eng)
            $("ul.model-list .has-subname").append("<li data-car_id=#{sub['id']} class='cursor'>#{str} - #{sub['year_range']}</li>")
          else
            $("ul.model-list .has-subname").append("<li data-car_id=#{sub['id']} class='cursor'>#{str} - #{sub['year_range']} - #{eng}</li>")



  generateCarModel = (letter, brname)-> #生成车系
    brands = $.jStorage.get("auto-#{letter}")
    brand = _.where(brands, {name: brname})
    auto_models = brand[0]['auto_models']
    $("ul.series-list").html("")

    _.each auto_models, (model)->
      $("ul.series-list").append("<li data-model_id='#{model['id']}' class='cursor'>#{model['name']}</li>")

  generateCarBrand = (letter) -> #生成品牌
    brands = $.jStorage.get("auto-#{letter}")
    _.each brands, (brand)->
      str = "<li data-letter=#{letter} class='cursor'><img src='#{brand['logo']}'/> <span>#{brand['name']}</span></li>"
      $("ul.brand-list").append(str)

  generateCarIndex = (autos)-> #生成索引
    _.each autos, (auto)->
      $.jStorage.set("auto-#{auto['initial']}", auto['autos']) #将单条 数据存储
      $("ul.crumbs").append("<li class='cursor'><a href='javascript:;'>#{auto['initial']}</a></li>")

