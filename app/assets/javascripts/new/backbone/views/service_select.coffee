class App.Views.ServiceSelect extends Backbone.View

  el: '.second'

  events:
    "click .service-items > li": "switchLeft"
    "click .items-list > li ": "switchRight"

  initialize: ->
    @order = new App.Models.Order

    @$left = @$("ul.left > li")
    @$right = @$("ul.right > li")
    @$parts = @$("li.cursor")
    @$price = @$(".price_ele")

    @order.set 'price', ""
    @order.set 'car_id', ""
    @order.set 'service_price', ""

    @listenTo(@order, 'sync', @render)
    @listenTo(@order, 'error', @errorHandler)

  render: ->

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