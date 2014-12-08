class Kalading.Views.Items extends Backbone.View

  el: '#main'

  events:
    "change .part": "resetSelectItems"
    "click .item-selector": "chooseParts"
    "click #order_button": "submitOrder"

  initialize: ->
    @order = new Kalading.Models.Order

    @$parts = @$(".part")
    @$price = @$(".price")
    @$service_price = @$(".service-price")
    @$checkboxes = @$(".item-selector")
    @$order_button = @$("#order_button")

    @resetSelectItems()

    @order.set 'price', @$price.data('price')
    @order.set 'car_id', $("#main").data('car')
    @order.set 'service_price', @$service_price.data('price')

    @listenTo(@order, 'change', @renderPrice)

  resetSelectItems: =>
    console.log 'reset select item'
    parts = _.map @$(".part:enabled option:selected"), (el, index) ->
      brand: $(el).data('brand')
      number: $(el).data('number')

    console.log parts

    @order.set 'parts', parts

    @disableSelectors()

  chooseParts: (e)=>
    $checkbox = $(e.target)
    checked = $checkbox.prop('checked')

    $checkbox.siblings('.part').attr('disabled', !checked)

    @resetSelectItems()

  renderPrice: ->
    console.log 'render price'
    @$price.text(@order.get('price'))
    @$service_price.text(@order.get('service_price'))
    @recoverSelectors()

  submitOrder: ->
    console.log @order.attributes

  disableSelectors: ->
    @$price.addClass "disabled"
    @$checkboxes.attr('disabled', true)
    @$order_button.attr('disabled', true)

  recoverSelectors: ->
    @$price.removeClass "disabled"
    @$checkboxes.attr('disabled', false)
    @$order_button.attr('disabled', false)
