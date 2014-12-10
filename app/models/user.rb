class User < ActiveRecord::Base
  validates :openid, :uniqueness => true
  belongs_to :public_account
  has_many :messages

  def self.update_weixin_user(account_name, openid)
    user = User.find_by(openid: openid)
    unless user
      User.create_weixin_user(account_name, openid)
    else
      user.update_attributes(user.set_weixin_user_info(account_name, openid))
      user
    end
  end

  def self.create_weixin_user(account_name, openid)
    begin
      user = User.new
      account ||= PublicAccount.get_account(account_name)
      user_info = account.user(openid)
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
      user.save!
      user
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error e
    end
  end

  def set_weixin_user_info(account_name, openid)
    account ||= PublicAccount.get_account(account_name)
    user_info = account.user(openid)
    attributes = {
      subscribe:      user_info.result["subscribe"],
      openid:         user_info.result["openid"],
      nickname:       user_info.result["nickname"],
      sex:            user_info.result["sex"],
      language:       user_info.result["language"],
      city:           user_info.result["city"],
      province:       user_info.result["province"],
      country:        user_info.result["country"],
      headimgurl:     user_info.result["headimgurl"],
      subscribe_time: user_info.result["subscribe_time"]
    }
    attributes
  end
end
