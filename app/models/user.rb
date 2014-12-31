class User < ActiveRecord::Base
  has_many :user_authinfos
  has_many :auth_infos, through: :user_authinfos

  has_many :autos
  has_many :service_addresses

  has_many :user_cities
  has_many :cities, through: :user_cities

  validates :phone_number, uniqueness: true
  before_create :generate_token

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
