$ ->
  if $('.activity99').length > 0
    $("#submit_button").on "click", ->
      $("#submit_button").addClass('disable').attr('disabled','disabled');
      phone_num = $("#phone_num").val()
      verification_code = $("#verification_code").val()
      car_license_num = $("#car_license_num").val()

      $.post "/phones", { phone_num: phone_num, code: verification_code, car_license_num: car_license_num }, (data) ->
        if data.success == true
          $('.share').animate({'top':'0'},200)
          $("html,body").animate({scrollTop:0},1000);
          $('.form-box').animate({'bottom':'-250px'},50).hide()
          $('.order-btn').text('约好了，等电话吧~')
          $('body').on "click", ->
            $('.share').animate({'top':'-150'},200)
            $('.bac').addClass('hidden')
        else
          alert('一定是姿势不对，请再约一次！')





