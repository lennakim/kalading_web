class Kalading.Models.Order extends Backbone.Model

  initialize: ->
    @on("change:parts", @loadPrice)
    #parts change 事件 会调用loadPrice
    #shooter的第一感觉是放在view中

  validate: (attrs, options) ->
    # unless attrs.price
    #   return "price should not be blank"
    unless attrs.car_id
      return "car_id should not be blank"

  loadPrice: ->
    data =
      car_id: @attributes['car_id']
      act: URI().search(true)['act']
      type: URI().search(true)['type']

    order = @

    if @isValid()
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
