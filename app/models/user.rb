class User < ActiveRecord::Base

  def self.get_client
    if $client == nil || User.token_expire?
      $client = WeixinAuthorize::Client.new(Settings.weixin_appid, Settings.weixin_appsecret)
    end

    $client.is_valid? ? $client : "invalid appid or appsecret"
  end

  def self.token_expire?
    if Settings[:weixin_token_expire] == nil || Settings[:weixin_token_expire] < Time.now
      Settings[:weixin_token_expire] = Time.now + 60*30
      true
    else
      false
    end
  end

end
