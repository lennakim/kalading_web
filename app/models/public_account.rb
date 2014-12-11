class PublicAccount < ActiveRecord::Base
  # It will auto generate weixin token and secret
  include WeixinRailsMiddleware::AutoGenerateWeixinTokenSecretKey
  has_many :users

  def weixin_client
    client = WeixinAuthorize::Client.new(self.appid, self.appsecret)
    client.is_valid? ? client : "invalid appid or appsecret"
  end

end
