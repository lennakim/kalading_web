class Kalading.Views.Items extends Backbone.View

  el: '.item-list'

  events:
    "change .part": "resetSelectItems"
    "click .list-group-item > .item": "chooseParts"
    "click .order_button": "submitOrder"
    "click #no_parts": "disableParts"
    "click #buy_parts": "enableParts"

  initialize: ->
    @order = new Kalading.Models.Order

    @$parts = @$(".list-group-item")
    @$price = $(".result-price")
    @$service_price = @$(".service-price")
    @$checkboxes = @$(".part-selector")
    @$order_button = @$("#order_button")
    @$no_parts = @$("#no_parts")
    @$buy_parts = @$("#buy_parts")


    @order.set 'price', @$price.data('price')
    @order.set 'car_id', $(".orders").data('car')
    @order.set 'service_price', @$service_price.data('price')

    @listenTo(@order, 'sync', @render)
    @listenTo(@order, 'error', @errorHandler)

    @resetSelectItems()
    @order.loadPrice()

  disableParts: (e)->
    $("#no_parts").parent('.list-group').children('li').removeClass('selected')
    $("#no_parts").addClass('selected')

    $('.item-part').addClass('disabled')
    $('.item-part .selected-part').each (i, part) ->

      $part = $(part)
      $part.removeData('brand')
      $part.removeData('number')
      $part.removeData('price')
      $part.removeClass('selected').children('.part-price').text('')

      name = $part.children('.part-name').data('name')
      $part.children('.part-name').text("未选择 #{ name }")

    $('.item-part .list-group-item').removeClass('selected')
    $(".service-fee").addClass('selected').children('.pull-left').text('已有配件, 仅购买上门服务')
    $('#service_fee').collapse('hide')

    @resetSelectItems()

  enableParts: (e) ->
    $("#buy_parts").parent('.list-group').children('li').removeClass('selected')
    $('#buy_parts').addClass('selected')

    if $('.item-part').hasClass('disabled')
      $('.item-part').removeClass('disabled')
      $(".service-fee").addClass('selected').children('.pull-left').text('购买配件，并上门服务')
      $('#service_fee').collapse('hide')

    @resetSelectItems()


  resetSelectItems: =>
    parts = _.map @$(".item-part:not(.disabled) .selected-part"), (el, index) ->
      brand: $(el).data('brand')
      number: $(el).data('number')

    @order.set 'parts', parts


  chooseParts: (e)=>

    $part = $(e.currentTarget)

    if $part.hasClass('cancel-selected')

      $part.closest('.list-group').children('.list-group-item').removeClass('selected')

      selected_part = $part.closest('.panel').find('.selected-part')
      selected_part.removeData('brand').removeData('number').removeClass('selected')

      name = selected_part.find('.part-name').data('name')
      selected_part.find('.part-name').text("未选择 #{ name }")
      selected_part.find('.part-price').text('')

    else

      brand  = $part.data('brand')
      number = $part.data('number')
      name   = $part.data('name')
      price  = $part.data('price')

      display_name = $part.data('display-name')

      if display_name && price

        $part.closest('ul.list-group').children('li.list-group-item').removeClass('selected')
        $part.parent('li.list-group-item').addClass('selected')
        $part.closest('.panel').find('.selected-part').addClass('selected')

        $part.closest('.panel').find('.selected-part')
          .data('brand', brand).data('number', number).data('name', name)
          .children('.part-name').text(display_name).end()
          .children('.part-price').text("￥ #{ price }")


    $part.closest('.collapse').collapse('hide')

    @resetSelectItems()
    @enableParts()

  render: ->
    # console.log 'render price'
    @$price.text(@order.get('price'))
    @$service_price.text(@order.get('service_price'))
    # @recoverSelectors()

  submitOrder: ->

    if $('.order_button').hasClass('haiwan-disabled')
      alert '感谢您参加海湾和卡拉丁的活动，今天的50个免费名额已经抢完了，明天10点继续开抢！您也可以去官网和微信端自费购买海湾润滑油保养，也有机会赢取大礼！'
    else
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
    # alert '服务器错误...请稍后再试'
    # @recoverSelectors()
