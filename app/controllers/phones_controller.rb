class PhonesController < ApplicationController

  def create
    if vcode = VerificationCode.find_by(phone_num: params[:phone_num], code: params[:code])

      payload = {
        info: {
          "phone_num" => params[:phone_num],
          "car_num" => params[:car_license_num],
          "client_comment" => "【活动】9块9可以约好多次哟"
        }
      }

      result = Order.submit_special_order payload
      if result["result"] == "succeeded"
        render json: { success: true }
      else
        render json: { success: false }
      end
    else
      render json: { success: false }
    end
  end

  def send_verification_code
    vcode = VerificationCode.find_valid_one params[:phone_num]
    success = vcode && vcode.send_sms

    render json: { success: success }
  end

end
