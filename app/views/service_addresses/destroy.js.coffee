$(".addresses .current_addresses").replaceWith $("<%= escape_javascript(render('service_addresses/addresses')) %>")
ajax_set_city()
