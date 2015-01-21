class PhonesController < ApplicationController

  def create
    vcode = VerificationCode.find_by(phone_num: params[:phone_num], code: params[:code])
    if vcode && !vcode.expired?

      account = PublicAccount.find_by(name: "kaladingcom")
      user = User.find_or_create_by(phone_number: vcode.phone_num)

      if account && auth_info = account.auth_infos.find_by(uid: cookies[:USERAUTH])
        unless user.auth_infos.include? auth_info
          user.auth_infos << auth_info
        end
      end

      if user && !signed_in?
        sign_in user
      end

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
