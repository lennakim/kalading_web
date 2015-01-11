#= require underscore
#= require backbone
#= require backbone_rails_sync
#= require backbone_datalink
#= require ./backbone/models/order.js
#= require ./backbone/views/items.js
#= require_self

$ ->

  if $(".items-select-page, .select-car-phone").length > 0
    items_view = new Kalading.Views.Items
    items_view.recoverSelectors()

  if $(".select-car-page").length > 0
    $('.select-car').css({'height':$('.quick-select').height()})

    $('.select-car,.quick-select').click ->
      $(this).addClass('selected').siblings().removeClass('selected')

      id = $('.select-item .selected #car_style option:selected').data('id') || $('.select-item .selected input:radio:checked').parent().next('button').data('id')

      $('.select-car-page').data 'car_id',id

    $('#to_select_item').click ->
      type = $('.select-car-page').data('type')
      car_id = $('.select-car-page').data 'car_id'
      window.location.href = "/orders/select_item?car_id=#{ car_id }&type=#{ type }"

  if $(".place-order-page,.place-order-phone").length > 0

    $('#no_invoice').on "click", (e) ->
      $('#invoice_info').collapse('hide')
    $("#yes_invoice").on "click", (e) ->
      $('#invoice_info').collapse('show')

    $('#no_preferential').on "click", (e) ->
      $('#preferential_info').collapse('hide')
    $("#yes_preferential").on "click", (e) ->
      $('#preferential_info').collapse('show')

    $("#validate_preferential").on "click", (e) ->
      e.preventDefault()
      e.stopPropagation()

      car_id = $('.place-order-page').data('car')
      code = $("#preferential_code").val()

      parts = $('#item_table').data("parts")

      $.post "/orders/validate_preferential_code", { code: code, car_id: car_id, parts: parts }

    $('#no_preferential').on "click", (e) ->
      e.preventDefault()
      e.stopPropagation()

      $("#yes_preferential").removeClass('active')
      $(@).addClass('active')

      car_id = $('.place-order-page').data('car')
      parts = $('#item_table').data("parts")

      $.post "/orders/no_preferential", { car_id: car_id, parts: parts }

    initPickaDate = ->
      nowDay = new Date()
      time = nowDay.getHours()

      if(time>=17)
        nowDay.setDate(nowDay.getDate()+2)
      else
        nowDay.setDate(nowDay.getDate()+1)

      maxDate = new Date()
      maxDate.setDate(maxDate.getDate()+8)

      $( '#serve_date' ).pickadate({
        min: nowDay,
        max: maxDate,
        today: '',
        format: 'yyyy-mm-dd'
      })

      $( '#registration_date' ).pickadate({
        max: true,
        today: 'Today',
        format: 'yyyy-mm-dd',
        selectMonths: true,
        selectYears: true
      })

    $("#commentForm").validate({
      rules: {
        phone_num: {
          number: true
        },
        friend_phone: {
          number: true
        }
      }
      messages: {
        name: "请输入姓名",
        address: "请输入详细地址",
        phone_num: {
          required: "请输入手机号码",
          minlength: "请输入11位手机号码",
          maxlength: "请输入11位手机号码",
          number: "手机号码应为数字"
        },
        car_num: {
          required: "请输入车牌号码",
          minlength: "请输入车牌后六位"
        },
        serve_datetime: {
          required: "请选择服务时间"
        },
        friend_phone: {
          minlength: "请输入11位手机号码",
          number: "手机号码应为数字"
        },
        registration_date: "请选择车辆注册时间"
      }
    })
    initPickaDate()

  if $('.success-page').length > 0
    num = 30
    countdown = ->
      if num > 0
        num--
      else
        window.location.href = '/'
      $('.num').text(num+"s")
      setTimeout(countdown,1000)
    countdown()
