class Kalading.Views.Items extends Backbone.View

  el: '#main'

  events:
    "change .part": "resetSelectItems"

  initialize: ->
    @order = new Kalading.Models.Order

    @$parts = @$(".part")
    @$price = @$(".price")

    @resetSelectItems()

    @order.set 'price', @$price.data('price')
    @order.set 'car_id', $("#main").data('car')

    @listenTo(@order, 'change:price', @renderPrice)

  resetSelectItems: (parts, price) =>
    console.log 'reset select item'
    parts = _.map @$(".part option:selected"), (el, index) ->
      brand: $(el).data('brand')
      number: $(el).data('number')

    @order.set 'parts', parts

    @disable_all()

  renderPrice: ->
    console.log 'render price'
    @recover_all()
    @$price.text(@order.get('price'))

  disable_all: ->
    @$price.addClass "disabled"
    @$parts.attr('disabled', true)

  recover_all: ->
    @$parts.attr('disabled', false)
    @$price.removeClass "disabled"
