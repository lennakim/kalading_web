$("#cancel_modal").modal('hide')
$("#order_<%= @id %>").replaceWith $("<%= escape_javascript(render('users/order_item', order: @order)) %>")
$("#order_detail").replaceWith $("<%= escape_javascript(render('orders/order_info', order: @order)) %>")
