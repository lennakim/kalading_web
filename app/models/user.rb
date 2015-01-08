class User < ActiveRecord::Base
  has_many :user_authinfos
  has_many :auth_infos, through: :user_authinfos

  has_many :autos
  has_many :service_addresses

  belongs_to :city

  validates :phone_number, uniqueness: true
  before_create :generate_token

  def add_auto order_info
    auto = autos.find_or_create_by \
      license_location: order_info["car_location"],
      license_number: order_info["car_num"]

    auto.update_attributes \
      system_id:        order_info["car_id"],
      brand:            "宝马(进口)",
      series:           "E",
      model_number:     "E200k（W211）2.0L 2006.09-2014",
      registed_at:      order_info["registration_date"],
      engine_number:    order_info["engine_num"],
      vin:              order_info["vin"]
  end

  def set_default_address address
    if address
      self.default_address_id = address.id
      save
    end
  end

  def default_address
    default_address = default_address_id && ServiceAddress.find_by(id: default_address_id)

    default_address ? default_address : service_addresses.last
  end

  def set_city city
    if id
      self.city = city
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
