class WeixinController < ApplicationController
  def transform
    account_name = params[:account_name]
    activity_name = parmas[:activity_name]

    account = PublicAccount.find_by account_name

    callback_url = account.weixin_client.authorize_url \
      callback_sessions_url \
        name: account_name,
        go: "act_#{activity_name}",
        "snsapi_userinfo"

    redirect_to callback_url
  end
end
