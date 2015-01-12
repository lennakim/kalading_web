#= require_self
#= require underscore

$ ->

  if $('.user-info').length > 0

    $('.content').on "click", ".select-car input[name=car_brand]", (e) ->
      e.stopPropagation()

      id = $(@).data('id')
      car_num = $(@).data('car_num')

      $.get "/users/cars.js?car_id=#{ id }&car_num=#{ car_num }"

    $( '#registration_date' ).pickadate({
      max: true,
      today: 'Today',
      format: 'yyyy-mm-dd',
      selectMonths: true,
      selectYears: true
    })

    $(".orders").on "click", ".order .comment > .cmt > a", (e) ->
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
    $(@).find('.tag label').removeClass('active')


  if $("#comment_modal").length > 0
    $('.submit-comment button.orange-btn').click (e)->
      e.preventDefault()
      if $('.comment-tags .active').length > 0
        $(@).addClass('disabled')

        tags = _.map $('.comment-tags .active > input'), (e, i) ->
          e.value

        id = $(@).data('id')
        score = $('.comment-tags .tag.good .btn.active').length - $('.comment-tags .tag.bad .btn.active').length

        $.post "/orders/#{ id }/comment", { tags: tags, score: score }
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


  $("#maintain_report_modal").on "shown.bs.modal", ->
    $(".modal-backdrop").css('height', 2000)
