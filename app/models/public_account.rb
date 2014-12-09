class PublicAccount < ActiveRecord::Base
  # It will auto generate weixin token and secret
  include WeixinRailsMiddleware::AutoGenerateWeixinTokenSecretKey
  has_many :users

  def self.get_account(name)
    account = PublicAccount.find_by(name: name)
    puts "account is nil! Please create one first!"; return unless account

    account = WeixinAuthorize::Client.new(PublicAccount.account_info(name).appid,
                                            PublicAccount.account_info(name).appsecret)
    # You have to call this method to get the final account!
    account.is_valid? ? account : "invalid appid or appsecret"
  end

  def self.account_info(name)
    account_info = PublicAccount.find_by(name: name)
    account_info
  end
end
