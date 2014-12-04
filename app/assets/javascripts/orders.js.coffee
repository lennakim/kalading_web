#= require underscore
#= require backbone
#= require backbone_rails_sync
#= require backbone_datalink
#= require_self
#= require ./backbone/models/order.js
#= require ./backbone/views/items.js

$ ->

  if $(".items-select-page")

    items_view = new Kalading.Views.Items
