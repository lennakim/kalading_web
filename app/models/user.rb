class User < ActiveRecord::Base
  belongs_to :publicaccount, class_name:"PublicAccount"
  has_many :messages, class_name:"Message"

  # return value is an Array type
  def self.get_followers_openid(weixin_id)
    client ||= PublicAccount.get_client(weixin_id)
    client.followers.result["data"]["openid"]
  end

  def self.get_follower_nickname(weixin_id, openid)
    user = User.find_by_openid openid
    if user == nil
      User.save_weixin_user openid
      client ||= PublicAccount.get_client(weixin_id)
      user_info = client.user(openid)
      user_info.result["nickname"]
    else
      user.nickname
    end
  end

  def self.update_weixin_user(weixin_id, openid)
    user = User.find_by_openid openid
    if user != nil
      user = user.set_weixin_user_info(weixin_id, openid)
      user.save!
    else
      User.save_weixin_user(weixin_id, openid)
    end
  end

  def self.save_weixin_user(weixin_id, openid)
    unless User.find_by_openid openid
      user = User.new
      user = user.set_weixin_user_info(weixin_id, openid)
      user.save!
    end
  end


  def set_weixin_user_info(weixin_id, openid)
    user = User.new
    client ||= PublicAccount.get_client(weixin_id)
    user_info = client.user(openid)
    user.subscribe = user_info.result["subscribe"]
    user.openid = user_info.result["openid"]
    user.nickname = user_info.result["nickname"]
    user.sex = user_info.result["sex"]
    user.language = user_info.result["language"]
    user.city = user_info.result["city"]
    user.province = user_info.result["province"]
    user.country = user_info.result["country"]
    user.headimgurl = user_info.result["headimgurl"]
    user.subscribe_time = user_info.result["subscribe_time"]
    user
  end

end
