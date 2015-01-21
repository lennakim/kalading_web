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

  if $(".select-car-phone").length > 0
    $('#myTab a').click (e) ->
      e.preventDefault()
      $(@).tab('show')
    
    if $('.quick-select input:radio:checked').length > 0 
      car_id = $('.quick-select input:radio:checked').parent().siblings('.btn').data('id')

      Turbolinks.visit("/orders/select_car_item?car_id=#{car_id}&type=bmt")
    
    $('.quick-select').on 'click','input:radio', ->
      car_id = $('.quick-select input:radio:checked').parent().siblings('.btn').data('id')
      auto_id = $('.quick-select input:radio:checked').parent().siblings('.btn').data('autoid')
      type = if $('.orders').data('type') then $('.orders').data('type') else 'bmt'
      
      Turbolinks.visit("/orders/select_car_item?car_id=#{car_id}&auto_id=#{auto_id}&type=#{type}")      

      $('.select-car-phone').attr('data-autoid', auto_id)
    
    $('.content').on 'click', '.service-item', (e) ->

      car_id = if $('.orders').data('car') ? $('.orders').data('car') then $('.orders').data('car') ? $('.orders').data('car') else $('.quick-select input:radio:checked').parent().siblings('.btn').data('id')

      auto_id = $('.select-car-phone').attr('data-autoid')
      type = $(@).data('type')

      Turbolinks.visit "/orders/select_car_item?car_id=#{car_id}&auto_id=#{auto_id}&type=#{type}"

    autoid = $('.select-car-phone').attr('data-autoid')
    type = $('.orders').data('type')
    
    $('.btn').each ->
      if $(this).data('autoid') == autoid
        $(this).siblings('span').find('input:radio').attr('checked','checked')
    
    $('.service-item').each ->
      if $(this).data('type') == type
        $(this).find('input:radio').attr('checked','checked')


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
        Turbolinks.visit("/orders/select_item?car_id=#{ id }&type=#{ type }&auto_id=#{ auto_id }")
      else
        Turbolinks.visit("/orders/select_item?car_id=#{ id }&type=#{ type }")


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

    disabled = disabled[0]

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

    $('#registration_date').pickadate({
      container: '#registed_date_picker',
      max: true,
      today: 'Today',
      format: 'yyyy-mm-dd',
      selectMonths: true,
      selectYears: true
    })


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
