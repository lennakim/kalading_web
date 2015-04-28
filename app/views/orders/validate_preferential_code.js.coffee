<% if error = @result['discount']['error'] %>
  # alert '<%= error %>'
  alert '优惠券错误'
<% else %>
  $("#item_table").replaceWith $("<%= escape_javascript(render('offer_table')) %>")
  $("#final_price").text("<%= @result['price'] %>")
  $("#result_price").text("<%= @result['price'] %>")
  $("#preferential_code").prop "readonly", true
<% end %>
