class Kalading.Models.Order extends Backbone.Model

  initialize: ->
    @on("change:parts", @loadNewPrice)

  validate: (attrs, options) ->
    unless attrs.price
      return "price should not be blank"
    unless attrs.car_id
      return "car_id should not be blank"

  loadNewPrice: ->

    data = {order: @attributes}
    order = @

    if @isValid()

      $.ajax
        type: 'post',
        url: '/orders/refresh_price',
        data: data,
        success: (data) ->
          order.set 'price', data['result']['price']
