class Kalading.Models.Order extends Backbone.Model

  initialize: ->
    @on("change:parts", @loadPrice)

  validate: (attrs, options) ->
    # unless attrs.price
    #   return "price should not be blank"
    unless attrs.car_id
      return "car_id should not be blank"

  submit: ->

    console.log @attributes.parts
    data_json = JSON.stringify(@attributes.parts)
    $.cookie('order', data_json)

    # csrf_token = $("meta[name='csrf-token']").attr('content')
    # data = {
    #   order: @attributes,
    #   authenticity_token: csrf_token,
    #   act: URI().search(true)['act'],
    #   auto_id: URI().search(true)['auto_id'],
    #   type: URI().search(true)['type']
    # }
    #
    # if @isValid()
    #   $.form('/orders/place_order', data).submit()

  loadPrice: ->
    data =
      order: @attributes
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
