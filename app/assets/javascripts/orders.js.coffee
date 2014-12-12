#= require underscore
#= require backbone
#= require backbone_rails_sync
#= require backbone_datalink
#= require ./backbone/models/order.js
#= require ./backbone/views/items.js
#= require_self

$ ->

  $('#search_button').click ->
    id = $('#car_style option:selected').data 'id'
    window.location.href = "/orders/select_item?car_id=#{id}"

  initPickaDate= ->
    nowDay = new Date()
    time = nowDay.getHours()

    if(time>=17)
      nowDay.setDate(nowDay.getDate()+2)
    else
      nowDay.setDate(nowDay.getDate()+1)
    
    maxDate = new Date()
    maxDate.setDate(maxDate.getDate()+8)

    $( '#serve_datetime' ).pickadate({
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

  if $(".items-select-page").length > 0
    items_view = new Kalading.Views.Items
    items_view.recoverSelectors()

  if $(".select-car-page").length > 0
    $('#car_style').chained('#car_type,#car_name')
    $('#car_type').chained('#car_name')

  if $(".place-order-page").length > 0
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
