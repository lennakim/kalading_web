class App.Views.ServiceSelect extends Backbone.View

  el: '.second'

  events:
    "click .service-items > li": "switchLeft"
    "click .items-list > li ": "switchRight"
    "click .undo ": "undoParts"

  initialize: ->
    @order = new App.Models.Order

    @$left = @$("ul.left > li")
    @$right = @$("ul.right > li")
    @$parts = @$("li.cursor")
    @$total_price = @$(".total_price") #selector
    @$service_price = @$(".service_price") #selector

    @order.set 'price', @$total_price.data('price')
    @order.set 'car_id', ""
    @order.set 'service_price', @$service_price.data('price')

    @listenTo(@order, 'sync', @render)
    @listenTo(@order, 'error', @errorHandler)

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
    text = self.text()
    index = self.addClass('active').siblings().removeClass('active').parents('.items-list').index()-1
    @$('.service-items li').eq(index).text(text).addClass('selected')

  undoParts: (e) =>
    self = $(e.target)
    part = self.parents("ul.items-list").data('part')

    point = $("ul.service-items>li[data-part='#{part}']")
    point.html("未选择")
