$("#item_table").closest('.section').replaceWith $("<%= escape_javascript(render('offer_table')) %>")
$(".new-offer-table").replaceWith $("<%= escape_javascript(render('new_offer_table')) %>")
$("#final_price").text("<%= @result['price'] %>")
$("#result_price").text("<%= @result['price'] %>")
$("#preferential_code").val("").prop "readonly", false
$("#validate_preferential").removeClass('hidden')
$("#no_preferential").addClass('hidden')
