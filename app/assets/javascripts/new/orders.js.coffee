#= require ./backbone/models/order
#= require ./backbone/views/service_select
#= require ./backbone/views/car_select
#= require_self

$ ->
  if $(".first").length > 0
    car_select = new App.Views.CarSelect #调用Backbone

  if $(".second").length > 0
    service_select = new App.Views.ServiceSelect
    #替換 sub2 url
    uri = URI()
    car_id = uri.search(true)['car_id']
    _.each $(".products .sub2 ul").find("a"), (ele)->
      type =  $(ele).data("type")
      path = uri.search({car_id: car_id, type: type })
      $(ele).attr("href", path)

  #------选车型---------

  #------跳转到选 排量------
  $('.first .series-list').on 'click','li', ->
    #已选择的车系tag
    series_name = $(@).text()
    $('.selected-series').removeClass('hide').find('.series').text(series_name)
    #选择排量标签
    $('.select-model').addClass('active')
    #显示选择排量 隐藏其他两个
    $('.first .maintain-items .items').addClass('hide').eq(2).removeClass('hide')


  #------删除已选品牌 跳转回选品牌------
  $('.selected-name .remove').click ->
    $('.first .items').addClass('hide').eq(0).removeClass('hide')
    $('.select-series,.select-model').removeClass('active')


  #------删除已选车系 或 点击上一步 跳转回选车系------
  $('.selected-series-name .remove').click ->
    $('.first .items').addClass('hide').eq(1).removeClass('hide')
    $('.select-model').removeClass('active')


  #-----未找到车型------
  $(".back-select-car").on "click", ->
    $(".no_car_type, .quick_select_car").addClass("hide")
    $(".first").removeClass("hide")


  #-----返回上一步------
  $('.second .prev').click ->
    $('.first').removeClass('hide').next().addClass('hide')

  $('.third .prev').click ->
    $('.second').removeClass('hide').next().addClass('hide')


  #快捷车辆
  $('.items').on 'click','.car-item', ->
    $('.car-item').removeClass('selected')
    $(@).addClass('selected')
    car_id = $(@).data("car_id")
    ele = $(@).parents(".quick_select_car").find(".next")
    ele.find("a").attr("car_id", car_id)

  $(".next[mark='new_car_select']").click ->
    ele = $(@).find("a")
    link = ele.data("link")
    car_id = ele.attr("car_id")
    type = URI().search(true)['type'] || "bmt"

    if car_id?
      window.location.href = "#{link}?car_id=#{car_id}&type=#{type}"
    else
      alert("请选择车辆")

  $(".flexslider").flexslider
    animation: "slide",
    animationLoop: false
    itemWidth: 210
    itemMargin: 5
    minItems: 2
    maxItems: 4
    slideshow: false

  # 添加车辆
  $("span.add-car").click ->
    $(".quick_select_car").addClass('hide')
    $(".first").removeClass('hide')

  # 未找到车型
  $(".undefined-car").click ->
    $(".no_car_type").removeClass("hide")
    $(".first").addClass("hide")
    $(".quick_select_car").addClass("hide")


  #######################new_service_select################

  #-----服务选项切换------
  $('.service-items li:first-child').addClass('active')

  $('.second .items-list,.second .items-list-small').height($('.second .left').height()-40)
  $('.service-items').on 'click','li', ->
    $('.second .leftbtn').css({'top':$(@).position().top+44})

  if $('.second .items-list').length == 0
    $('.leftbtn').addClass('hide')


  # order form page

  if $('.new-order-form, .no_car_type').length > 0


    $('#verification_code').on 'blur', (e) ->
      code = $(@).val()
      phone_num = $("#phone_num").val()
      car_id = $("#car_id").val()
      if phone_num.length == 11 && code.length == 6
        console.log 1
        $.get "/users/get_user_info?phone_num=#{phone_num}&code=#{code}&car_id=#{car_id}", (data) ->
          if data && !data['error']
            console.log data
            $("#name").val(data['name'])
            $("#registration_date").val(data['auto_registration_date'])
            car_location = data['car_num'][0]
            car_num = data['car_num'][1 .. -1]

            $("select.car_location option[value=#{car_location}]").attr('selected', true)
            $("#car_num").val(car_num)
            if $(".service-address-detail").length == 0
              service_location = data['address']
              $("#selected_address").val(service_location)
              $.cookie('address', service_location)
              $(".current_addresses").html """
                <li class="service-address-item selected">
                  <label>
                    <input type="radio" name="address" value="#{data['address']}" checked>
                    <span class='address-name'>
                      #{ data['address'] }
                    </span>
                  </label>
                </li>
              """


    $("#place_order_form").on "ajax:before", (xhr, settings)->
      $("#submit_form_button").attr('disabled', true)

    $('#address_manage').on 'click', (e) ->
      e.preventDefault()
      e.stopPropagation()

      if $('.addr .edit').hasClass('hide')
        $('.addr .edit').removeClass('hide')
      else
        $('.addr .edit').addClass('hide')

    ####  以下为下单页面城市选择部分  ####

    $("#service_districts").chained("#service_cities")
    $('#service_districts').on 'change', (e) ->
      city = $("#service_cities").val()
      district = $("#service_districts").val()
      ac.setInputValue "#{city}#{district}"

    # add address modal
    $("#add_address_modal").on "click", ".add-address > button", (e) ->
      e.preventDefault()
      e.stopPropagation()
      $(@).addClass('disabled')
      $modal = $(e.delegateTarget)
      city = $modal.find('select.city').val()
      district = $modal.find('select.district').val()

      detail = $modal.find('#address_detail').val()
      if $.trim(detail) != ""
        $.post "/service_addresses", { service_address: { city: city, district: district, detail: detail } }

      else
        $modal.find("#address_detail").closest(".form-group").addClass("has-error")

    $("#add_address_modal").on "hidden.bs.modal", ->
      $(@).find(".add-address > button").removeClass('disabled')

    $("#address_detail").on "keyup", (e) ->
      $button = $("#add_address_modal .add-address > button")
      if e.keyCode == 13 && !$button.hasClass('disabled')
        $button.trigger "click"

    ####  以上为下单页面城市选择部分  ####

    # select address
    $(".addresses .add > a").on "click", (e)->
      e.stopPropagation()
      e.preventDefault()
      $("#add_address_modal").modal()

    $('.addresses').on 'change', '.service-address-item input[type=radio]', (e) ->
      id = $(@).data('id')

      $('.service-address-item').removeClass('selected')
      $(@).closest('.service-address-item').addClass('selected')

      $.post "/service_addresses/#{ id }/set_default"

    $("#validate_preferential").on "click", (e) ->
      e.preventDefault()
      e.stopPropagation()

      car_id = $("#car_id").val()
      code = $("#preferential_code").val()
      type = $("#service_type").val()

      $.post "/orders/validate_preferential_code", { code: code, car_id: car_id, type: type }

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
        # container: '#date_picker',

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

    $('#registration_date').pickadate({
      # container: '#date_picker',
      max: true,
      format: 'yyyy-mm-dd',
      selectMonths: true,
      selectYears: true,
      close: "关闭"
    })

    # 設定 服务时间
    set_serve_date $('#serve_date').data('cc')

    $.validator.addMethod "regx", (value, element, regexpr) ->
      regexpr.test(value)
    ,  "车牌号不合法"


    ###### js validate ####
    $("#place_order_form").validate

      highlight: (element, errorClass, validClass) ->
        $(element).closest('.form-inline').addClass('has-error')
        # $(element.form).find("label[for=" + element.id + "]")
        #   .addClass(errorClass)

      unhighlight: (element, errorClass, validClass) ->
        $(element).closest('.form-inline').removeClass('has-error')
        # $(element.form).find("label[for=" + element.id + "]")
        #   .removeClass(errorClass)

      errorPlacement: (error, element) ->
        # 不提醒

        # element.data('title', error[0].innerText)
        # element.tooltip
        #   placement: 'left'
        # .tooltip 'show'
        #

      submitHandler: (form) ->
        if !$("#serve_date").val()
          $("#serve_date").closest('.form-inline').addClass('has-error')
          return false

        else if ($("#registration_date").length > 0 && !$("#registration_date").val())
          $("#registration_date").closest('.form-inline').addClass('has-error')
          return false
        else
          return true

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
