window.App =
  Views: {}
  Models: {}

class App.Models.Order extends Backbone.Model

  initialize: ->
    @on("change:parts", @loadPrice)

  validate: (attrs, options) ->
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
          console.log("refresh_price success")
          order.set 'price', data['result']['price']
          order.set 'service_price', data['result']['service_price']
          order.trigger 'sync'
        error: (data) ->
          console.log("refresh_price error")
          order.trigger 'error'
    else
      console.log("data verification error")