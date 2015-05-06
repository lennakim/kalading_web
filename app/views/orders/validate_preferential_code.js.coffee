<% if @result['discount']['error'] %>
  alert '优惠券错误'
<% else %>
  $("#item_table").closest('.section').replaceWith $("<%= escape_javascript(render('offer_table')) %>")
  $("#final_price").text("<%= @result['price'] %>")
  $("#result_price").text("<%= @result['price'] %>")
  $("#preferential_code").prop "readonly", true
  $("#validate_preferential").addClass('hidden')
  $("#no_preferential").removeClass('hidden')
<% end %>
