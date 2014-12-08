class Kalading.Views.Items extends Backbone.View

  el: '#main'

  events:
    "change .part": "resetSelectItems"
    "click .item-selector": "chooseParts"

  initialize: ->
    @order = new Kalading.Models.Order

    @$parts = @$(".part")
    @$price = @$(".price")
    @$checkboxes = @$(".item-selector")

    @resetSelectItems()

    @order.set 'price', @$price.data('price')
    @order.set 'car_id', $("#main").data('car')

    @listenTo(@order, 'change:price', @renderPrice)

  resetSelectItems: =>
    console.log 'reset select item'
    parts = _.map @$(".part:enabled option:selected"), (el, index) ->
      brand: $(el).data('brand')
      number: $(el).data('number')

    console.log parts

    @order.set 'parts', parts

    @disable_all()

  chooseParts: (e)=>
    $checkbox = $(e.target)

    if $checkbox.prop('checked')
      $checkbox.siblings('.part').attr('disabled', false)
    else
      $checkbox.siblings('.part').attr('disabled', true)

    @resetSelectItems()

  renderPrice: ->
    console.log 'render price'
    @recover_all()
    @$price.text(@order.get('price'))

  disable_all: ->
    @$price.addClass "disabled"
    @$checkboxes.attr('disabled', true)

  recover_all: ->
    @$price.removeClass "disabled"
    @$checkboxes.attr('disabled', false)
