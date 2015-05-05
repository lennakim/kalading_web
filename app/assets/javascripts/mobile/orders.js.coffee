#= require underscore
#= require backbone
#= require backbone_rails_sync
#= require backbone_datalink
#= require ./backbone/models/order.js
#= require ./backbone/views/items.js
#= require_self

$ ->

  $('.data-img').each ->
    imgSrc = $(this).attr('data-src')
    $(this).attr('src',imgSrc)

  if $(".select_car_by_initial").length > 0

    $('.brand').on 'click','.brand_title', ->

      $(@).parent().siblings().find('li').removeClass('active')
      $(@).addClass('active')
      $('.model').addClass('hidden')

      $('.serie').addClass('hidden')
      $('.title_con').removeClass('hidden')
      if $(@).next('.serie').find('li').length != 0
        $(@).siblings('.serie').removeClass('hidden').animate({'left':'30%'},500,->
          $('.logo').addClass('logo_active')
          $('.title_con').addClass('title_active')
        )

    flag = 0
    $('.serie').on 'click','.serie_title', ->
      if flag == 0
        $(@).addClass('active')
        $(@).next('.model').removeClass('hidden')
        flag = 1
      else
        $(@).removeClass('active')
        $(@).next('.model').addClass('hidden')
        flag = 0

    $('.crumbs').on 'click','li', ->
      $('.logo').removeClass('logo_active')
      $('.title_con').removeClass('title_active')
      $('.serie').addClass('hidden')
      $('.brand_title').removeClass('active')
      classname = $(@).attr('class')
      $('.letter').each ->
        id = $(@).attr('id')
        if classname == id
          height = $('#'+id).offset().top
          $('html,body').animate({scrollTop: height}, 500)

  if $(".select-car-phone").length > 0
    items_view = new Kalading.Views.Items

    $('#myTab a').click (e) ->
      e.preventDefault()
      $(@).tab('show')

  if $('.place-order-phone').length > 0

    $(".place-order-phone").on 'click', '.list-group-item > .address-item-detail > a', (e) ->
      e.preventDefault()
      e.stopPropagation()
      id =  $(@).data('id')

      $(@).closest('.list-group').find('li.list-group-item').removeClass('selected')
      $(@).closest('li.list-group-item').addClass('selected')

      $.post "/service_addresses/#{ id }/set_default"

    $("#place_order_form").on "ajax:beforeSend", ->
      $("#submit_form_button").attr('disabled', true)

    $("#place_order_form").on "ajax:complete", ->
      $("#submit_form_button").attr('disabled', false)

    if $('.current_addresses .service-address-detail').length == 0
      $('.add a').click()

    $("#validate_preferential").on "click", (e) ->
      e.preventDefault()
      e.stopPropagation()

      car_id = $("#car_id").val()
      code = $("#preferential_code").val()
      type = $("#service_type").val()

      parts = $('#item_table').data("parts")

      $.post "/orders/validate_preferential_code", { code: code, car_id: car_id, parts: parts, type: type }

    $('#no_preferential').on "click", (e) ->
      e.preventDefault()
      e.stopPropagation()

      $("#yes_preferential").removeClass('active')
      $(@).addClass('active')
      type = $("#service_type").val()

      car_id = $("#car_id").val()
      parts = $('#item_table').data("parts")

      $.post "/orders/no_preferential", { car_id: car_id, parts: parts, type: type }

    @ajax_set_city = ->
      address = $.trim $('.current_addresses .service-address-detail').text()
      if address
        $.get "/cities/city_capacity.json?address=#{address}", (data) ->
          set_serve_date data

    set_serve_date = (date) ->

      activity_id = $("#activity_id").val()

      min = new Date(_.first(_.keys(date)))
      max = new Date(_.last(_.keys(date)))

      disabled = _.select _.pairs(date), (e) ->
        sum = _.reduce e[1], (memo, num) ->
          memo + num
        , 0

        sum == 0

      disabled_date = _.map disabled, (e, i) ->
        new Date(e[0])

      time_slot = {
        "8:00": "8:00 - 12:00",
        "12:00": "12:00 - 17:00",
        "17:00": "17:00 - 20:00"
      }


      if activity_id == '140'
        max = new Date(2015, 5, 30)

      $input = $('#serve_date').pickadate({

        container: '#date_picker',

        editable: false,

        format: 'yyyy-mm-dd',
        min: min,
        max: max,
        onSet: () ->

          if activity_id != '140'
            $("#serve_period").empty()
            date_string = $("#serve_date").val()

            _.each date[date_string], (e, i) ->
              key = Object.keys(time_slot)[i]
              value = time_slot[key]

              if e != 0
                option = """
                  <option value="#{key}">#{value}</option>
                """

                $("#serve_period").append($(option))

      })

      picker = $input.pickadate('picker')
      picker.set('enable', true)
      picker.set('disable', disabled_date)
      picker.clear()


    set_serve_date $('#serve_date').data('cc')

    $('#registration_date').pickadate({
      container: '#date_picker',

      editable: false,

      max: true,
      today: 'Today',
      format: 'yyyy-mm-dd',
      selectMonths: true,
      selectYears: true
    })

    $.validator.addMethod "regx", (value, element, regexpr) ->
      regexpr.test(value)
    ,  "车牌号不合法"

    $("#place_order_form").validate

      highlight: (element, errorClass, validClass) ->
        $(element).closest('.form-group').addClass('has-error')
        # $(element.form).find("label[for=" + element.id + "]")
        #   .addClass(errorClass)

      unhighlight: (element, errorClass, validClass) ->
        $(element).closest('.form-group').removeClass('has-error')
        # $(element.form).find("label[for=" + element.id + "]")
        #   .removeClass(errorClass)


      errorPlacement: (error, element) ->

        # 不提醒

        # element.data('title', error[0].innerText)
        # element.tooltip
        #   placement: 'left'
        # .tooltip 'show'


      rules:
        phone_num:
          required: true
          number: true
          minlength: 11
          maxlength: 11

        verification_code:
          required: true
          number: true
          minlength: 6
          maxlength: 6

        serve_date:
          required: true
          date: true

        registration_date:
          required: true
          date: true

        car_num:
          required: true
          minlength: 6
          maxlength: 6
          regx: /^[a-zA-Z]{1}[a-zA-Z_0-9]{5}$/


      messages:
        name: "请输入姓名"
        address: "请输入详细地址"
        verification_code: "请输入正确的短信验证码"

        phone_num:
          required: "请输入手机号码"
          minlength: "请输入11位手机号码"
          maxlength: "请输入11位手机号码"
          number: "手机号码应为数字"

        car_num:
          required: "请输入车牌号码"
          minlength: "请输入车牌后6位"
          maxlength: "请输入车牌后6位"

        serve_date:
          required: "请选择服务时间"

        registration_date:
          required: "请选择车辆注册时间"
