class SessionsController < ApplicationController

  def new
  end

  def create

    if vcode = VerificationCode.find_by(phone_num: params[:phone_num], code: params[:code])
      account = PublicAccount.find_by(name: "kalading1")
      if auth_info = account.auth_infos.find_by(uid: cookies[:USERAUTH])
        user = User.find_or_create_by(phone_number: vcode.phone_num)
        user.update(token: cookies[:USERAUTH])
        UserAuthinfo.create(user_id: user.id, auth_info_id: auth_info.id)
      else
        User.create(phone_number: vcode.phone_num)
      end
    end

    redirect_to root_path
  end

  def callback
    # Here got two params, one is params[:code], another one is params[:state]

    account = PublicAccount.find_by(name:"kalading1")
    client = account.weixin_client
    sns_info = client.get_oauth_access_token(params[:code])
    expires_in = sns_info.result["expires_in"].seconds.from_now.utc
    cookies[:USERAUTH] = { value: sns_info.result["openid"], expires: 30.days.from_now }
    auth_info = account.auth_infos.find_or_create_by(provider:"weixin",
                                                          uid:sns_info.result["openid"])
    auth_info.update(token: sns_info.result["access_token"], expires_at: expires_in)


    follower = client.get_oauth_userinfo(sns_info.result["openid"],
                                         sns_info.result["access_token"])
    Rails.logger.info("------follower nickname: #{follower.result["nickname"]},
                      expires_in: #{sns_info.result["expires_in"]}")

    redirect_to root_path
  end

end
