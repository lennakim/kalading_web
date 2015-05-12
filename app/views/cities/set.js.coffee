$("#select_city_modal").modal('hide')
$("nav .address span.city").text("<%= current_city_name %>")
$("#current_city .city-name").text("<%= current_city_name %>")
window.available_service = [<%= raw City.find(current_user_city).products.map(&:slug).map{|name| %-"#{name}"- }.join(', ') %>]
