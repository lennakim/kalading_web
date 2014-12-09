class User < ActiveRecord::Base
  belongs_to :public_account
  has_many :messages

  def self.update_weixin_user(name, openid)
    user = User.find_by(openid: openid)
    unless user
      User.save_weixin_user(name, openid)
    else
      user = user.set_weixin_user_info(name, openid)
      user.save!
      user
    end
  end

  def self.save_weixin_user(name, openid)
    user =  User.find_by(openid: openid)
    unless user
      user = User.new
      user = user.set_weixin_user_info(name, openid)
      user.save!
      user
    else
      user
    end
  end

  def set_weixin_user_info(name, openid)
    account ||= PublicAccount.get_account(name)
    user_info = account.user(openid)

    user = User.new
    user.subscribe      = user_info.result["subscribe"]
    user.openid         = user_info.result["openid"]
    user.nickname       = user_info.result["nickname"]
    user.sex            = user_info.result["sex"]
    user.language       = user_info.result["language"]
    user.city           = user_info.result["city"]
    user.province       = user_info.result["province"]
    user.country        = user_info.result["country"]
    user.headimgurl     = user_info.result["headimgurl"]
    user.subscribe_time = user_info.result["subscribe_time"]
    user
  end

end
