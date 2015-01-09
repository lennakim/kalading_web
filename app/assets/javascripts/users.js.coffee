#= require_self
#= require underscore

$ ->

  if $('.user-info').length > 0

    $(".orders").on "click", ".order .comment > .cmt > a", (e)->
      e.stopPropagation()
      e.preventDefault()

      id = $(@).data('order')
      $(".submit-comment button.orange-btn").data('id', id)

      $("#comment_modal").modal()

    $("#add_car").on "click", (e) ->
      e.preventDefault()
      e.stopPropagation()

      $("#select_car_modal").modal()

  $('#comment_modal').on 'hidden.bs.modal', ->
    $(@).find(".btn").removeClass('disabled').removeClass('active')
    $(@).find('input').val("")
    $(@).find('textarea').val("")


  if $("#comment_modal").length > 0
    $('.submit-comment button.orange-btn').click (e)->
      e.preventDefault()
      if $('.comment-tags .active').length > 0
        $(@).addClass('disabled')

        tags = _.map $('.comment-tags .active > input'), (e, i) ->
          e.value

        id = $(@).data('id')
        content = $(".comment-area textarea").val()
        score = $('.comment-tags .tag.good .btn.active').length - $('.comment-tags .tag.bad .btn.active').length

        $.post "/orders/#{ id }/comment", { content: content, tags: tags, score: score }
      else
        alert "请选择评价标签"

  $('.orders').on "click", ".order .order-status a", (e) ->
    e.preventDefault()
    e.stopPropagation()

    area = $(@).closest('.order').find('.status')
    if area.hasClass('hidden')
      area.removeClass('hidden')
    else
      area.addClass('hidden')

