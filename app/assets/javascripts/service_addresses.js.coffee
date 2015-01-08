$ ->
  $(".addresses").on "change", ".radio input[type=radio]", (e) ->
    id = $(@).data('id')
    $.post "/service_addresses/#{ id }/set_default"
