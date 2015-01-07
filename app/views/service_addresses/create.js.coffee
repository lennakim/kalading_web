$("#add_address_modal").modal('hide')
$(".addresses .current_addresses").html $("<%= escape_javascript(render('service_addresses/addresses')) %>")
