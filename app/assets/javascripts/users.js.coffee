#= require_self
#= require underscore

$ ->

  ####
  if $(".users-new").length > 0
    $('#car_style').chained('#car_type,#car_name')
    $('#car_type').chained('#car_name')

  ####

  if $('.user-info').length > 0

    $(".orders").on "click", ".order .comment a", (e)->
      e.stopPropagation()
      e.preventDefault()

      $("#comment_modal").modal()

  if $("#comment_modal").length > 0
    $('.submit-comment button.orange-btn').click (e)->
      e.preventDefault()
      if $('.comment-tags .active').length > 0
        $(@).addClass('disabled')

        tags = _.map $('.comment-tags .active > input'), (e, i) ->
          e.value

        comment = tags.join(', ')

        $.post '/xxx', comment
