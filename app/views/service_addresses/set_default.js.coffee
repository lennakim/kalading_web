$('.quick-address-select .service-address-detail').text('<%= current_user.default_address.full_address %>')
$("#selected_address").val("<%= current_user.default_address.full_address %>")
$('#select_addr').collapse('hide')
ajax_set_city()
