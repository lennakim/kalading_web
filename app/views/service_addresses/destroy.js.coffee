$(".addresses .current_addresses").replaceWith $("<%= escape_javascript(render('service_addresses/addresses')) %>")
<% if current_user && current_user.default_address %>
$("#selected_address").val("<%= current_user.default_address.full_address %>")
<% end %>
ajax_set_city()
