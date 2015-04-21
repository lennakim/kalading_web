module V2
  class Users < Grape::API

    resources :users do

      params do
        requires :phone, regexp: /^\d{11}$/, desc: "11位纯数字"
      end
      post "send_verification_sms" do
        phone = params[:phone]
        vcode = VerificationCode.create(phone_num: phone)
        result = vcode.valid? && vcode.send_sms
        status(200)
        wrapper(result)
      end

      params do
        requires :phone, regexp: /^\d{11}$/, desc: "11位纯数字"
        requires :code,  regexp: /^\d{6}$/, desc: "6 位纯数字"
      end
      post "login" do
        phone = params[:phone]
        code = params[:code]
        vcode = VerificationCode.find_by(phone_num: phone, code: code)

        status(200)

        if vcode && !vcode.expired?
          user = User.find_or_create_by(phone_number: vcode.phone_num)

          wrapper(user.login_info)
        else
          raise TokenExpiredError
        end
      end
    end
  end
end