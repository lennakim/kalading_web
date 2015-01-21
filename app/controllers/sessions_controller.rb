class SessionsController < ApplicationController

  def new
  end

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
    end

    if user
      sign_in user
      redirect_to orders_users_path
    else
      redirect_to root_path(login: 1)
    end
  end

  def callback
    # redirect_url = http://ohcoder.ngrok.com/sessions/callback?name=kaladingcom&go=xx_yy
    # Here got four params: params[:code], params[:state], params[:name], params[:go]

    account = PublicAccount.find_by(name: params[:name])
    client = account.weixin_client
    sns_info = client.get_oauth_access_token(params[:code])
    expires_in = sns_info.result["expires_in"].seconds.from_now.utc
    cookies[:USERAUTH] = { value: sns_info.result["openid"], expires: 30.days.from_now }
    auth_info = account.auth_infos.find_or_create_by(provider:"weixin",
                                                     uid:sns_info.result["openid"])
    auth_info.update(token: sns_info.result["access_token"], expires_at: expires_in)

    if signed_in?
      unless current_user.auth_infos.include? auth_info
        current_user.auth_infos << auth_info
      end
    end

    go = params[:go]
    go_somewhere = go.split("_").first

    case go_somewhere
    when "act"
      go_content = go.split("_").second
      url = "http://kalading.com/activities/#{go_content}?from=dab5e6b582ad98c1c23c89d10c4cb6f2"
      redirect_to url
    else
      redirect_to root_path(login:1)
    end

  end

  def destroy
    cookies.delete(:LGT)
    redirect_to '/'
  end

end
