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
    # items_view.recoverSelectors()

  if $(".select-car-page").length > 0
    $('.select-car, .quick-select').click ->

      $('.select-car, .quick-select').removeClass('selected')
      $(@).addClass('selected')


  $('#to_select_item').click ->

    $area = $('.select-car-page .selected')
    if $area.hasClass('select-car')
      id = $('#car_style option:selected').data('id')
    else
      id = $(".quick-select input:radio:checked").data('id')
      auto_id = $(".quick-select input:radio:checked").data('autoid')

    type = $('.select-car-page').data('type') || 'bmt'
    if auto_id
      window.location.href = "/orders/select_item?car_id=#{ id }&type=#{ type }&auto_id=#{ auto_id }"
    else
      window.location.href = "/orders/select_item?car_id=#{ id }&type=#{ type }"


  if $(".place-order-page,.place-order-phone").length > 0
    if $('.address input').length == 0
      $('.add a').click()

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

      car_id = $("#car_id").val()
      code = $("#preferential_code").val()

      parts = $('#item_table').data("parts")

      $.post "/orders/validate_preferential_code", { code: code, car_id: car_id, parts: parts }

    $('#no_preferential').on "click", (e) ->
      e.preventDefault()
      e.stopPropagation()

      $("#yes_preferential").removeClass('active')
      $(@).addClass('active')

      car_id = $("#car_id").val()
      parts = $('#item_table').data("parts")

      $.post "/orders/no_preferential", { car_id: car_id, parts: parts }


    date = $('#serve_date').data('cc')
    min = _.first(_.keys(date))
    max = _.last(_.keys(date))

    disabled = _.select _.pairs(date), (e) ->
      e[1].length == 0

    disabled_date = _.map disabled, (e, i) ->
      new Date(e)

    $('#serve_date').pickadate({

      container: '#serve_date_picker',

      format: 'yyyy-mm-dd',
      min: new Date(min),
      max: new Date(max),
      disable: disabled_date,
      onSet: () ->
        # date_string = $("#serve_date").val()
        # _.each date[date_string], (e, i) ->
        #   console.log e
        #   if e == 0
        #     $("#serve_period option").find(i).addClass('hidden')

    })

    $( '#registration_date' ).pickadate({
      container: '#registed_date_picker',
      max: true,
      today: 'Today',
      format: 'yyyy-mm-dd',
      selectMonths: true,
      selectYears: true
    })


    initPickaDate = ->
      nowDay = new Date()
      time = nowDay.getHours()

      if(time>=17)
        nowDay.setDate(nowDay.getDate()+2)
      else
        nowDay.setDate(nowDay.getDate()+1)

      maxDate = new Date()
      maxDate.setDate(maxDate.getDate()+8)



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
