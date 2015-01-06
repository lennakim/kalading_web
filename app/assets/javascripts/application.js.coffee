#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require turbolinks
#= require jquery.chained.remote.min
#= require jquery.form
#= require jquery.validate.min
#= require picker
#= require legacy
#= require picker.date
#= require picker.time
#= require bootstrap-sprockets
#
#= require home
#= require users
#
#= require_self

window.Kalading =
  Views: {}
  Models: {}

$ ->

  $('#car_style').chained('#car_type,#car_name')
  $('#car_type').chained('#car_name')
