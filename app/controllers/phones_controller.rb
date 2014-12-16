class PhonesController < ApplicationController

  def create
    if vcode = VerificationCode.find_by(phone_num: params[:phone_num], code: params[:code])

      payload = {
        info: {
          "phone_num" => params[:phone_num],
          "car_num" => params[:code],
          "client_comment" => "三万卡粉活动"
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
  end

end
