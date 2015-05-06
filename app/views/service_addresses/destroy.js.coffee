$(".addresses .current_addresses").replaceWith $("<%= escape_javascript(render('service_addresses/addresses')) %>")
$("#selected_address").val("<%= current_user.default_address.full_address %>")
ajax_set_city()
