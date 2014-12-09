class PublicAccount < ActiveRecord::Base
  # It will auto generate weixin token and secret
  include WeixinRailsMiddleware::AutoGenerateWeixinTokenSecretKey
  has_many :users

  def self.get_account(name)
    account = PublicAccount.find_by(name: name)
    unless account
      puts "account is nil! Please create one first!"
      return
    end
    account = WeixinAuthorize::Client.new(account.appid, account.appsecret)
    # You have to call this method to get the final account!
    account.is_valid? ? account : "invalid appid or appsecret"
  end

  def account_info(name)
    account_info = PublicAccount.find_by(name: name)
    account_info
  end
end
