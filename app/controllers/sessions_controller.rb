class SessionsController < ApplicationController

  def new
  end

  def create
    # fake login user

    if vcode = VerificationCode.find_by(phone_num: params[:phone_num], code: params[:code])
      User.create(phone_number: vcode.phone_num)
    end

    redirect_to root_path
  end

  def callback
  end

  def send_verification_code
    vcode = VerificationCode.find_valid_one params[:phone_num]
    success = vcode && vcode.send_sms

    render json: { success: success }
  end

end
