$("#comment_modal").modal('hide')
$("#order_<%= @id %>").replaceWith $("<%= escape_javascript(render('users/order_item', order: @order)) %>")
