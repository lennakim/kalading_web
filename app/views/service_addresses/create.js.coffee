$("#add_address_modal").modal('hide')
$(".addresses .current_addresses").replaceWith $("<%= escape_javascript(render('service_addresses/addresses')) %>")
