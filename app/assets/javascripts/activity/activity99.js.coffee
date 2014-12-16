$ ->
  if $('.activity99').length > 0
    $("#submit_button").on "click", ->
      phone_num = $("#phone_num").val()
      verification_code = $("#verification_code").val()
      car_license_num = $("#car_license_num").val()

      $.post "/phones", { phone_num: phone_num, code: verification_code, car_license_num: car_license_num }, (data) ->
        if data.success == true
          $('.share').animate({'top':'0'},200)
          $('.form-box').animate({'bottom':'-250px'},50)
          $('body').on "click", ->
            $('.share').animate({'top':'-150'},200)
            $('.bac').addClass('hidden')
        else
          alert('预约失败')

  data = {
    'img': $('.activity99').data('thumbnail'),
    'link': $('.activity99').data('link'),
    'desc': '他们都贴了No 霾 in Car——万名卡粉邀你入伙！
9块9，可以约很多次哦！',
    'title': '他们都贴了No 霾 in Car——万名卡粉邀你入伙！
9块9，可以约很多次哦！'
  }

  wechat('timeline', data)
