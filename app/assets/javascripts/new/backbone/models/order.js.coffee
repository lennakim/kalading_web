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
    alert(1)
    data =
      car_id: @attributes['car_id']
      act: URI().search(true)['act']
      type: URI().search(true)['type']

    car_id=  @attributes['car_id']
    act=  URI().search(true)['act']
    type= URI().search(true)['type']
    alert("#{car_id} #{act} #{type}")

    order = @

    if true #@isValid()
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