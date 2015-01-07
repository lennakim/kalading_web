class User < ActiveRecord::Base
  has_many :user_authinfos
  has_many :auth_infos, through: :user_authinfos

  has_many :autos
  has_many :service_addresses

  belongs_to :city

  validates :phone_number, uniqueness: true
  before_create :generate_token

  def set_default_address address
    if address
      self.default_address_id = address.id
      save
    end
  end

  def default_address
    default_address_id ? ServiceAddress.find(default_address_id)  : service_addresses.last
  end

  def set_city city_name
    if city_name
      self.city = City.find_by name: city_name
      save
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
