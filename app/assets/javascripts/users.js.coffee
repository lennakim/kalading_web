#= require_self
#= require underscore

$ ->

  if $('.user-info').length > 0

    $(".orders").on "click", ".order .comment > .cmt > a", (e)->
      e.stopPropagation()
      e.preventDefault()

      $("#comment_modal").modal()

    $("#add_car").on "click", (e) ->
      e.preventDefault()
      e.stopPropagation()

      $("#select_car_modal").modal()

  if $("#comment_modal").length > 0
    $('.submit-comment button.orange-btn').click (e)->
      e.preventDefault()
      if $('.comment-tags .active').length > 0
        $(@).addClass('disabled')

        tags = _.map $('.comment-tags .active > input'), (e, i) ->
          e.value

        comment = tags.join(', ')

        $.post '/xxx', comment

  $('.orders').on "click", ".order .order-status a", (e) ->
    e.preventDefault()
    e.stopPropagation()

    area = $(@).closest('.order').find('.status')
    if area.hasClass('hidden')
      area.removeClass('hidden')
    else
      area.addClass('hidden')

