class User < ActiveRecord::Base

  validates :phone_number, :uniqueness => true
  has_many :platforms, dependent: :destroy

  before_create :generate_token

  class << self
    def from_auth(auth)
      locate_auth(auth) || create_auth(auth)
    end

    def locate_auth(auth)
      Platform.locate(auth).try(:user)
    end

    def create_auth(auth)
      create!(
        nickname:         auth["nickname"],
        headimgurl:       auth["image"],
        platforms_attributes: [
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

end
