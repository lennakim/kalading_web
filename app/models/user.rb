class User < ActiveRecord::Base

  validates :openid, :uniqueness => true
  has_many :messages, dependent: :destroy
  has_many :authentications, dependent: :destroy

  belongs_to :public_account

  accepts_nested_attributes_for :authentications
  before_create :generate_token

  class << self
    def from_auth(auth)
      locate_auth(auth) || create_auth(auth)
    end

    def locate_auth(auth)
      Authentication.locate(auth).try(:user)
    end

    def create_auth(auth)
      create!(
        nickname:         auth["nickname"],
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

  def self.check_or_create weixin_id, openid
    user = User.find_by openid: openid
    unless user
      account = PublicAccount.find_by weixin_id: weixin_id
      weixin_client = account.weixin_client
      user_info = weixin_client.user openid
      user = account.users.new
      user.set_user_info user_info
      user.save
    end
    user
  end

  def set_user_info user_info
    self.subscribe      = user_info.result["subscribe"]
    self.openid         = user_info.result["openid"]
    self.nickname       = user_info.result["nickname"]
    self.sex            = user_info.result["sex"]
    self.language       = user_info.result["language"]
    self.city           = user_info.result["city"]
    self.province       = user_info.result["province"]
    self.country        = user_info.result["country"]
    self.headimgurl     = user_info.result["headimgurl"]
    self.subscribe_time = user_info.result["subscribe_time"]
  end

end
