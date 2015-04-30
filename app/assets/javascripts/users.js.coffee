#= require_self
#= require underscore

$ ->

  if $('.user-info').length > 0

    if $('.phone-page').length > 0
      $('.user-info').on 'click', '.order-detail', (e) ->
        e.preventDefault()
        e.stopPropagation()
        id = $(@).data('id')

        Turbolinks.visit("/orders/#{ id }")


    $('.content').on "click", ".select-car input[name=car_brand]", (e) ->
      e.stopPropagation()

      id = $(@).data('id')
      car_num = $(@).data('car_num')

      $.get "/users/cars.js?car_id=#{ id }&car_num=#{ car_num }"

    $(".orders").on "click", ".order .comment > .del > a", (e) ->
      e.stopPropagation()
      e.preventDefault()

      id = $(@).data('order')

      $("#cancel_modal_submit").data('id', id)
      $("#cancel_modal").modal()

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

  $("#cancel_modal").on 'click', 'input[type=radio]', ->

    $("#cancel_modal_submit").removeClass('disabled')

    if $(@).attr('id') == "other_reason"
      $(".textarea").slideDown()
    else
      $(".textarea").slideUp()

  $("#cancel_modal_cancel").click (e)->
    e.stopPropagation()
    e.preventDefault()
    $("#cancel_modal").modal('hide')

  $(".textarea").on "keyup", ->
    $(@).removeClass('has-error')

  $("#cancel_modal_submit").click (e) ->

    e.stopPropagation()
    e.preventDefault()

    radio = $("#cancel_modal input[type=radio]:checked")

    if radio.attr('id') == "other_reason"
      submit_content = $.trim $('.textarea textarea').val()
    else
      submit_content = $.trim radio.closest('li').find('div:first label').text()

    id = $("#cancel_modal_submit").data('id')
    url = "/orders/#{id}.js"
    data = { reason: submit_content }
    if submit_content
      $.ajax({url: url, type: 'DELETE', data: data})
    else
      $(".textarea").addClass('has-error')


  $("#cancel_modal").on "hidden.bs.modal", ->
    $('.textarea').hide().find('textarea').val('')
    $('#cancel_modal input[type=radio]').prop('checked', false)
    $("#cancel_modal_submit").addClass('disabled')


  $('#comment_modal').on 'hidden.bs.modal', ->
    $(@).find(".btn").removeClass('disabled').removeClass('active')
    $(@).find('.tag label').removeClass('active')


  if $("#comment_modal").length > 0

    select_star = ->
      index = $(@).index()
      $(@).addClass('active').siblings().removeClass('active')
      $('.comment-stars img').each ->
        if $(@).index() <= index
          $(@).attr('src','/assets/star2.png')
        else
          $(@).attr('src','/assets/star1.png')

    $('.comment-stars').on 'mouseover','img', select_star

    $('.comment-stars').on 'click','img', select_star


    $('.submit-comment button.orange-btn').click (e)->
      e.preventDefault()

      id = $(@).data('id')
      score = $('.comment-stars .active').attr('value')
      desc = $('#comment_con').val()

      $.post "/orders/#{ id }/comment", { score: score, desc: desc }


      #if $('.comment-tags .active').length > 0
        #$(@).addClass('disabled')

        #tags = _.map $('.comment-tags .active > input'), (e, i) ->
          #e.value

        #id = $(@).data('id')
        #score = $('.comment-tags .tag.good .btn.active').length - $('.comment-tags .tag.bad .btn.active').length

        #$.post "/orders/#{ id }/comment", { tags: tags, score: score }
      #else
        #alert "请选择评价标签"

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

