class App.Views.ServiceSelect extends Backbone.View

  el: '.second'

  events:
    "click .service-items > li": "switchLeft"
    "click .items-list > li ": "switchRight"
    "click .undo ": "undoParts"
    "click .all-undo": "undoAllParts"

  initialize: ->
    @order = new App.Models.Order

    @service_type =  URI().search(true)['type']

    @$total_price = @$(".total_price") #selector
    @$service_price = @$(".service_price") #selector

    @order.set 'price',  @$total_price.data('price')
    @order.set 'car_id', $(".second").data("car_id") #car_id
    @order.set 'service_price', @$service_price.data('price') #bty service_price is zero

    @listenTo(@order, 'sync', @render)
    @listenTo(@order, 'error', @errorHandler)

    @resetSelectItems() #初始化的时候把数据塞入 cookie

  render: ->
    @$total_price.text(@order.get('price')) #渲染
    @$service_price.text(@order.get('service_price')) #渲染

  switchLeft: (e) =>
    # http://stackoverflow.com/a/5680837/1240067
    self = $(e.target)
    index = self.index()
    self.addClass('active').siblings().removeClass('active')
    @$('.items-list').addClass('hide').eq(index).removeClass('hide')

  switchRight: (e) =>
    self = $(e.target)
    self.addClass("active").siblings().removeClass('active')
    text = self.text()
    part = self.data('part')
    brand = self.attr('brand')
    number = self.attr('number')
    point = $("ul.service-items>li[data-part='#{part}']")
    point.attr('brand', brand).attr('number', number).addClass('selected').removeClass("disabled").text(text)
    @resetSelectItems()

  undoParts: (e) =>
    self = $(e.target)
    part = self.parents("ul.items-list").data('part')
    point = $("ul.service-items>li[data-part='#{part}']")
    point.addClass('disabled').attr('brand', '').attr('number', '').html("未选择")

    @resetSelectItems()

  undoAllParts: (e) =>
    $("ul.service-items >li").addClass('disabled').attr('brand', '').attr('number', '').html("未选择")
    @resetSelectItems()

  resetSelectItems: =>
    parts = _.map $(".service-items > li:not(.disabled)"), (ele, index) ->
      brand: $(ele).attr('brand')
      number: $(ele).attr('number')

    data_json = JSON.stringify(parts)

    $.cookie('parts', data_json)

    @order.set 'parts', parts

