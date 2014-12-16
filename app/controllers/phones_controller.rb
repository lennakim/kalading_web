class PhonesController < ApplicationController

  def create
    if vcode = VerificationCode.find_by(phone_num: params[:phone_num], code: params[:code])

      # # create a order to backend
      # car_license = params[:car_license]
      #
      # ServerApi.call 'orders', {}

      render json: { success: true }
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
