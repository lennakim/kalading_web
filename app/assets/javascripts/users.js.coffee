#= require_self

$ ->
  if $(".users-new").length > 0
    $('#car_style').chained('#car_type,#car_name')
    $('#car_type').chained('#car_name')
