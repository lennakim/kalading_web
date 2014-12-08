class Kalading.Models.Order extends Backbone.Model

  initialize: ->
    @on("change:parts", @loadPrice)

  validate: (attrs, options) ->
    # unless attrs.price
    #   return "price should not be blank"
    unless attrs.car_id
      return "car_id should not be blank"

  loadPrice: ->
    data = {order: @attributes}
    order = @

    if @isValid()
      console.log 'load price'
      $.ajax
        type: 'post',
        url: '/orders/refresh_price',
        data: data,
        success: (data) ->
          order.set 'price', data['result']['price']
          order.set 'service_price', data['result']['service_price']
          order.trigger 'sync'
        error: (data) ->
          order.trigger 'error'

