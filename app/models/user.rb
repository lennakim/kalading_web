class User < ActiveRecord::Base
  validates :openid, :uniqueness => true
  belongs_to :public_account
  has_many :messages

  def self.find_or_create_by weixin_name, openid
    user = User.find_by openid: openid
    unless user
      account = PublicAccount.find_by name: weixin_name
      weixin_client = account.weixin_client
      user_info = weixin_client.user openid
      user = account.users.new
      user.set_user_info user_info
      user.save
      return user
    end
    user
  end

  def set_user_info user_info
      self.subscribe      = user_info.result["subscribe"],
      self.openid         = user_info.result["openid"],
      self.nickname       = user_info.result["nickname"],
      self.sex            = user_info.result["sex"],
      self.language       = user_info.result["language"],
      self.city           = user_info.result["city"],
      self.province       = user_info.result["province"],
      self.country        = user_info.result["country"],
      self.headimgurl     = user_info.result["headimgurl"],
      self.subscribe_time = user_info.result["subscribe_time"]
  end

end
