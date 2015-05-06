$("#add_address_modal").modal('hide')
$("#selected_address").val("<%= current_user.default_address.full_address %>")
$(".addresses .current_addresses").replaceWith $("<%= escape_javascript(render('service_addresses/addresses')) %>")
ajax_set_city()
