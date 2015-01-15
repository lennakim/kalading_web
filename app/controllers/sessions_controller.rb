class SessionsController < ApplicationController

  def new
  end

  def create

    vcode = VerificationCode.find_by(phone_num: params[:phone_num], code: params[:code])

    if vcode && !vcode.expired?
      account = PublicAccount.find_by(name: "kaladingcom")
      user = User.find_or_create_by(phone_number: vcode.phone_num)

      if account && auth_info = account.auth_infos.find_by(uid: cookies[:USERAUTH])
        begin
          user.auth_infos << auth_info
        rescue ActiveRecord::RecordInvalid => e
          # ...
          Rails.logger.info '-' * 30
          Rails.logger.error e
        end
      end
    end

    if user
      sign_in user
      redirect_to orders_users_path
    else
      redirect_to root_path(login: 1)
    end
  end

  def callback
    # redirect_url = http://ohcoder.ngrok.com/sessions/callback?name=kaladingcom
    # Here got three params: params[:code], params[:state], params[:name]

    account = PublicAccount.find_by(name: params[:name])
    client = account.weixin_client
    sns_info = client.get_oauth_access_token(params[:code])
    expires_in = sns_info.result["expires_in"].seconds.from_now.utc
    cookies[:USERAUTH] = { value: sns_info.result["openid"], expires: 30.days.from_now }
    auth_info = account.auth_infos.find_or_create_by(provider:"weixin",
                                                     uid:sns_info.result["openid"])
    auth_info.update(token: sns_info.result["access_token"], expires_at: expires_in)

    if signed_in?
      begin
        current_user.auth_infos << auth_info
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.info '-' * 30
        Rails.logger.error e
      end
    end

    redirect_to root_path(login:1)
  end

  def destroy
    cookies.delete(:LGT)
    redirect_to '/'
  end

end
