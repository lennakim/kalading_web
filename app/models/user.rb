class User < ActiveRecord::Base

  def self.get_access_token

    if Settings[:weixin_access_token] == nil ||
      (Settings[:weixin_token_expire] &&
       Settings[:weixin_token_expire] < Time.now)

      url = "#{Settings.weixin_api}token?grant_type=client_credential&appid="\
            "#{Settings.weixin_appid}&secret=#{Settings.weixin_appsecret}"

      result = RestClient.get url

      access_token = JSON.parse result

      Settings[:weixin_token_expire] = Time.now + 60*30

      if access_token['access_token']
        Settings[:weixin_access_token] = access_token['access_token']
        access_token['access_token']
      else
        access_token['errmsg']
      end
    end

    Settings[:weixin_access_token]

  end


end
