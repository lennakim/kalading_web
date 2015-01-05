#= require underscore
#= require backbone
#= require backbone_rails_sync
#= require backbone_datalink
#= require ./backbone/models/order.js
#= require ./backbone/views/items.js
#= require_self

$ ->

  if $(".items-select-page").length > 0
    items_view = new Kalading.Views.Items
    items_view.recoverSelectors()

  if $(".select-car-page").length > 0
    $('#car_style').chained('#car_type,#car_name')
    $('#car_type').chained('#car_name')

    $('.search_button').click ->
      id = $('#car_style option:selected').data 'id'
      type = $('.select-car-page').data('type')
      window.location.href = "/orders/select_item?car_id=#{id}&type=#{type}"

    $('.my-car').each ->
      $(this).click ->
        if $(this).find('input').is(':checked')
          $(this).addClass('selected')
          $(this).next('.my-car-info').css({'borderColor':'#ffd4a9'})
        else
          $(this).removeClass('selected')
          $(this).next('.my-car-info').css({'borderColor':'#e1e1e1'})

    $('.my-car var').each ->
      $(this).click ->
        _myCar = $(this).parent()
        _myCarInfo = _myCar.next('.my-car-info')

        if _myCar.hasClass('down')
          _myCar.removeClass('down')
          _myCarInfo.removeClass('show-con')
        else
          _myCar.addClass('down').siblings('.my-car').removeClass('down')
          _myCarInfo.addClass('show-con').siblings('.my-car-info').removeClass('show-con')

  if $(".place-order-page").length > 0
    initPickaDate = ->
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

    $('.address-list').on 'mouseover','.address-item', ->
      _close = $(this).find('.close')
      if $(this).hasClass('selected-item')
        _close.addClass('hidden')
        $(this).css({'borderColor':'#ffd4a9'})
      else
        _close.removeClass('hidden')
        $(this).css({'borderColor':'#ffd4a9'})

    $('.address-list').on 'mouseout','.address-item', ->
      _close = $(this).find('.close')
      if $(this).hasClass('selected-item')
        _close.addClass('hidden')
        $(this).css({'borderColor':'#ef7337'})
      else
        _close.addClass('hidden')
        $(this).css({'borderColor':'#f1f1f1'})

    $('.address-list').on 'click','.close', ->
      $(this).parent('.address-item').remove()

    $('.address-list').on 'click','.address-item', ->
      _close = $(this).find('.close')
      _selected = $(this).find('.selected')

      $(this).addClass('selected-item').css({'borderColor':'#ef7337'}).siblings().removeClass('selected-item').css({'borderColor':'#f1f1f1'})

      _selected.removeClass('hidden').parent().siblings().find('.selected').addClass('hidden')

      _close.addClass('hidden')

      showTitle()

    showTitle = ->
      if $('.address-list').children().length != 0
        $('.choice-title').removeClass('hidden')
      else
        $('.choice-title').addClass('hidden')

    $('.add-address').on "click", ->
      city = $('#city_name option:selected').text()
      town = $('#town_name option:selected').text()
      address = $('#address').val()
      $('.address-list').prepend('<dl class="address-item"><dt>'+city+' '+town+'</dt><dd>'+address+'</dd><dd class="close hidden"></dd><dd class="selected hidden"></dd></dl>')

      showTitle()



