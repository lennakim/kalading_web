class User < ActiveRecord::Base

  #####  for login  #####

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  before_create :generate_token

  class << self
    def from_auth(auth)
      # locate_auth(auth) || create_auth(auth)
      locate_auth(auth) || create_auth(auth)
    end

    def locate_auth(auth)
      Authentication.locate(auth).try(:user)
    end

    def create_auth(auth)
      create!(
        nickname:    auth["nickname"],
        headimgurl:       auth["image"],
        authentications_attributes: [
          {
            provider:      auth["provider"],
            uid:           auth["uid"],
            token:         auth["token"],
            expires_at:    auth["expires_at"]
          }])
    end
  end

  def update_user
    generate_token!
    token
  end

  def generate_token!
    generate_token
    save
  end

  def generate_token
    begin
      self.token = (Digest::MD5.hexdigest "#{SecureRandom.urlsafe_base64(nil, false)}-#{Time.now.to_i}")
    end while User.where(token: self.token).exists?
  end

  ####

  def self.get_client
    if $client == nil || User.token_expire?
      $client = WeixinAuthorize::Client.new(Settings.weixin_appid, Settings.weixin_appsecret)
    end

    $client.is_valid? ? $client : "invalid appid or appsecret"
  end

  # return value is a Array type
  def self.get_all_followers_openid
    $client ||= User.get_client
    $client.followers.result["data"]["openid"]
  end

  def self.get_follower_nickname(openid)
    user = User.find_by_openid openid
    if user == nil
      User.save_weixin_user openid
      $client ||= User.get_client
      user_info = $client.user(openid)
      user_info.result["nickname"]
    else
      user.nickname
    end
  end


  def self.token_expire?
    if Settings[:weixin_token_expire] == nil || Settings[:weixin_token_expire] < Time.now
      Settings[:weixin_token_expire] = Time.now + 60*30
      true
    else
      false
    end
  end

  def self.update_weixin_user(openid)
    user = User.find_by_openid openid
    if user != nil
      user = user.set_weixin_user_info(openid)
      user.save!
    else
      User.save_weixin_user(openid)
    end
  end

  def self.save_weixin_user(openid)
    unless User.find_by_openid openid
      user = User.new
      user = user.set_weixin_user_info(openid)
      user.save!
    end
  end


  def set_weixin_user_info(openid)
    user = User.new
    $client ||= User.get_client
    user_info = $client.user(openid)
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
