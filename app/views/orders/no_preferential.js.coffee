$("#item_table").replaceWith $("<%= escape_javascript(render('offer_table')) %>")
$("#final_price").text("<%= @result['price'] %>")
$("#preferential_code").val("").prop "readonly", false
