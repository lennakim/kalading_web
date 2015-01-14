class Kalading.Views.Items extends Backbone.View

  el: '.orders-con'

  events:
    "change .part": "resetSelectItems"
    "click .part-selector": "chooseParts"
    "click .order_button": "submitOrder"
    "click #no_parts": "cleanParts"

  initialize: ->
    @order = new Kalading.Models.Order

    @$parts = @$(".part")
    @$price = @$(".price")
    @$service_price = @$(".service-price")
    @$checkboxes = @$(".part-selector")
    @$order_button = @$("#order_button")
    @$no_parts = @$("#no_parts")


    @order.set 'price', @$price.data('price')
    @order.set 'car_id', $(".orders").data('car')
    @order.set 'service_price', @$service_price.data('price')

    @listenTo(@order, 'sync', @render)
    @listenTo(@order, 'error', @errorHandler)

    @resetSelectItems()
    @order.loadPrice()

  cleanParts: (e)->

    if checked = @$no_parts.prop('checked')
      $('.part-selector').prop('checked', false)
      $('select.part').prop('disabled', true)

      # $('.part').prop('disabled', true)

    else
      $('.part-selector').prop('checked', true)
      $('select.part').prop('disabled', false)
      # $('.part').prop('disabled', false)

    @resetSelectItems()


  resetSelectItems: =>
    parts = _.map @$(".part:enabled option:selected"), (el, index) ->
      brand: $(el).data('brand')
      number: $(el).data('number')

    @order.set 'parts', parts

    # @disableSelectors()

  chooseParts: (e)=>
    $checkbox = $(e.target)
    checked = $checkbox.prop('checked')
    $checkbox.closest('.item').find('.part').attr('disabled', !checked)

    $("input#no_parts").prop "checked", false

    @resetSelectItems()

  render: ->
    # console.log 'render price'
    $('.result-price').text(@order.get('price'))
    @$price.text(@order.get('price'))
    @$service_price.text(@order.get('service_price'))
    # @recoverSelectors()

  submitOrder: ->
    @order.submit()

  # disableSelectors: ->
  #   @$price.addClass "disabled"
  #   @$checkboxes.attr('disabled', true)
  #   @$order_button.attr('disabled', true).addClass('disabled')

  # recoverSelectors: ->
  #   @$price.removeClass "disabled"
  #   if !@$no_parts.prop('checked')
  #     @$checkboxes.attr('disabled', false)
  #   @$order_button.attr('disabled', false).removeClass('disabled')

  errorHandler: ->
    alert '服务器错误...请稍后再试'
    @recoverSelectors()
