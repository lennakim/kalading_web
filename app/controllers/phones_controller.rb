class PhonesController < ApplicationController

  def create

    vcode = VerificationCode.find_by(phone_num: params[:phone_num], code: params[:code])

    if vcode && !vcode.expired?



      render json: { success: true }
    else
      render json: { success: false, msg: '手机或者验证码错误' }
    end
  end

  def send_verification_code
    vcode = VerificationCode.create phone_num: params[:phone_num]
    success = vcode.valid? && vcode.send_sms

    render json: { success: success }
  end

end
