class Kalading.Views.Items extends Backbone.View

  el: '#main'

  events:
    "change .part": "resetSelectItems"

  initialize: ->
    @order = new Kalading.Models.Order
    @resetSelectItems()
    @order.set 'price', $(".price").data('price')
    @order.set 'car_id', $("#main").data('car')

    @listenTo(@order, 'change:parts', @refreshPrice)
    @listenTo(@order, 'change:price', @changePrice)

  resetSelectItems: (parts, price) =>
    parts = _.map @$(".part option:selected"), (el, index) ->
      brand: $(el).data('brand')
      number: $(el).data('number')

    @order.set 'parts', parts

  refreshPrice: ->
    @order.loadNewPrice()

  changePrice: ->
    @$(".price").text(@order.get('price'))
