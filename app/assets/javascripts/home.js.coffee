$ ->

  if $('.home-page').length > 0

    $('.carousel').carousel()

    $('.maintain-item').on 'mouseover','dl', ->
      $(this).find('img').addClass('filter')
      $(this).find('.bac').removeClass('hidden')
      $(this).find('.con').addClass('show')
      $(this).find('.item-title').addClass('show-title')
    $('.maintain-item').on 'mouseout','dl', ->
      $(this).find('img').removeClass('filter')
      $(this).find('.bac').addClass('hidden')
      $(this).find('.con').removeClass('show')
      $(this).find('.item-title').removeClass('show-title')

    $('.get_code').click ->
      phone_num = $('#phone_num').val()
      $(this).addClass('disable').attr('disabled','disabled')
      seconds = 60

      if phone_num == ''
        alert('请输入手机号')
        $('.get_code').removeClass('disable').removeAttr('disabled')
      else
        $.ajax
          type: 'POST',
          url: '/phones/send_verification_code',
          data: {phone_num: phone_num},
          success: (data) ->
            if data.success
              timer = setInterval ->
                if seconds > 0
                  seconds -= 1
                  $('.get_code').text(seconds+'秒后重新获取')
                if seconds == 0
                  $('.get_code').removeClass('disable').removeAttr('disabled').text('重新获取')
                  clearInterval(timer)
              , 1000

            else
              alert('请输入正确手机号')
              $('.get_code').removeClass('disable').removeAttr('disabled')

    $("#submit_button").on "click", ->
      $("#submit_button").addClass('disable').attr('disabled','disabled')
      phone_num = $("#phone_num").val()
      verification_code = $("#verification_code").val()

      csrf_token = $("meta[name='csrf-token']").attr('content')
      data = { phone_num: phone_num, code: verification_code, authenticity_token: csrf_token }

      $.form('/sessions', data).submit()
