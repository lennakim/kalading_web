class User < ActiveRecord::Base

  scope :recent, -> {order(created_at: :desc)}
  has_many :user_authinfos
  has_many :auth_infos, through: :user_authinfos

  has_many :autos
  has_many :service_addresses

  belongs_to :city

  validates :phone_number, uniqueness: true
  before_create :generate_token

  def role
    return "editor" if Settings.editors.include?(phone_number)
    return "administrator" if Settings.administrators.include?(phone_number)
    return "customer"
  end

  def add_auto order_info
    auto = autos.find_or_create_by \
      license_location: order_info["car_location"],
      license_number: order_info["car_num"]

    auto_hash = Auto.api_find order_info["car_id"]

    auto.update_attributes \
      system_id:        order_info["car_id"],

      brand:            auto_hash.brand,
      series:           auto_hash.series,
      model_number:     auto_hash.model_number,

      registed_at:      order_info["registration_date"],
      engine_number:    order_info["engine_num"],
      vin:              order_info["vin"]
      logo:             order_info["logo"] #logo
  end

  def set_default_address address
    self.update(default_address_id: address.id) if address
  end

  def default_address
    default_address = default_address_id && ServiceAddress.find_by(id: default_address_id)

    default_address ? default_address : service_addresses.last
  end

  def set_city city
    self.update(city: city) if id
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

  def generate_expires_at
    # TODO 简单处理 不会过期
    self.expires_at = 1.years.from_now
  end

  def login_info
    { id: id, token: token }
  end
end
