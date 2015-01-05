class Kalading.Views.Items extends Backbone.View

  el: '.orders-con'

  events:
    "change .part": "resetSelectItems"
    "click .part-selector": "chooseParts"
    "click .order_button": "submitOrder"

  initialize: ->
    @order = new Kalading.Models.Order

    @$parts = @$(".part")
    @$price = @$(".price")
    @$service_price = @$(".service-price")
    @$checkboxes = @$(".part-selector")
    @$order_button = @$("#order_button")


    @order.set 'price', @$price.data('price')
    @order.set 'car_id', $(".orders").data('car')
    @order.set 'service_price', @$service_price.data('price')

    @listenTo(@order, 'sync', @render)
    @listenTo(@order, 'error', @errorHandler)

    @resetSelectItems()
    @order.loadPrice()

  resetSelectItems: =>
    parts = _.map @$(".part:enabled option:selected"), (el, index) ->
      brand: $(el).data('brand')
      number: $(el).data('number')

    @order.set 'parts', parts

    @disableSelectors()

  chooseParts: (e)=>
    $checkbox = $(e.target)
    checked = $checkbox.prop('checked')

    $checkbox.siblings('.part').attr('disabled', !checked)

    @resetSelectItems()

  render: ->
    console.log 'render price'
    @$price.text(@order.get('price'))
    @$service_price.text(@order.get('service_price'))
    @recoverSelectors()

  submitOrder: ->
    @order.submit()

  disableSelectors: ->
    @$price.addClass "disabled"
    @$checkboxes.attr('disabled', true)
    @$order_button.attr('disabled', true)

  recoverSelectors: ->
    @$price.removeClass "disabled"
    @$checkboxes.attr('disabled', false)
    @$order_button.attr('disabled', false)

  errorHandler: ->
    alert '服务器错误...请稍后再试'
    @recoverSelectors()
