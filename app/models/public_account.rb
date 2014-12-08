class PublicAccount < ActiveRecord::Base
  # It will auto generate weixin token and secret
  include WeixinRailsMiddleware::AutoGenerateWeixinTokenSecretKey
  has_many :users, class_name: "User"

  def self.get_client(weixin_id)
    account = PublicAccount.find_by_weixin_id weixin_id
    if account == nil
      puts "account is nil! Please create one first!"
      return
    end

    if $account_info == nil || PublicAccount.token_expire?
      $account_info = WeixinAuthorize::Client.new(PublicAccount.get_appid(weixin_id),
                                            PublicAccount.get_appsecret(weixin_id))
      # You have to call this method to get the final account_info!
      $account_info.is_valid? ? $account_info : "invalid appid or appsecret"
    else
      $account_info
    end
  end

  def self.get_weixin_id
    PublicAccount.pluck(:weixin_id)
  end

  def self.get_appid(weixin_id)
    account = PublicAccount.find_by_weixin_id weixin_id
    account.appid
  end

  def self.get_appsecret(weixin_id)
    account = PublicAccount.find_by_weixin_id weixin_id
    account.appsecret
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
