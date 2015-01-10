<% if error = @result['discount']['error'] %>
alert '<%= error %>'
<% else %>
$("#item_table").replaceWith $("<%= escape_javascript(render('offer_table')) %>")
$("#final_price").text("<%= @result['price'] %>")
$("#preferential_code").prop "readonly", true
<% end %>
