class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?
  helper_method :current_city, :current_city_id, :current_city_name
  helper_method :last_select_car, :current_user_city
  helper_method :aes128_encrypt, :aes128_decrypt

  before_action :set_city
  before_action :set_device_type

  # http_basic_authenticate_with name: 'staging', password: 'abcdefg' if Rails.env == "staging"
  #

  def sign_in user
    cookies[:LGT] = { value: user.token, expires: 30.days.from_now }
  end

  def signed_in?
    current_user.present?
  end

  def save_last_select_car id
    cookies[:last_select_car] = { value: id, expires: 365.days.from_now }
  end

  def last_select_car
    cookies[:last_select_car]
  end

  def current_user
    @current_user ||= User.find_by(token: cookies[:LGT]) if cookies[:LGT]
  end

  def current_user_city
    return current_user.city.id if current_user && current_user.city

    cookies[:city_id]
  end

  def extract_from_ip
    address = BaiduApi.ip_to_city(request.remote_ip)
    City.find_by(name: address.split('|')[2]).try(:id) if address
  end

  def default_city
    City.find_by(name: "北京")
  end

  def set_city
    city_id = current_user_city || extract_from_ip || default_city.id
    cookies[:city_id] = { value: city_id, expires: 360.days.from_now }
  end

  def current_city_name
    City.find(current_user_city).name
  end

  def current_city_id
    City.find(current_user_city).system_id
  end

  def aes128_encrypt(data)
    aes = OpenSSL::Cipher::AES.new(128, :CBC)
    aes.encrypt
    key = aes.random_key
    iv = aes.random_iv
    encrypted = cipher.update(data) + cipher.final
    return encrypted, key, iv
  end

  def aes128_decrypt(data, key, iv)
    aes = OpenSSL::Cipher::AES.new(128, :CBC)
    aes.descrypt
    aes.key = key
    aes.iv = iv
    aes.update(data) + aes.final
  end

  private

  def set_device_type
    request.variant = :phone if browser.mobile?
  end

end
