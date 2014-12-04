class Kalading.Models.Order extends Backbone.Model

  loadNewPrice: ->

    data = {order: @attributes}
    order = @

    $.ajax
      type: 'post',
      url: '/orders/refresh_price',
      data: data,
      success: (data) ->
        order.set 'price', data['result']['price']
