class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?
  helper_method :current_city, :current_city_id, :current_city_name

  before_action :set_city
  before_action :set_device_type

  def sign_in user
    cookies[:LGT] = { value: user.update_user, expires: 30.days.from_now }
  end

  def signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(token: cookies[:LGT]) if cookies[:LGT]
  end

  def current_user_locale
    return current_user.city.id if current_user && current_user.city

    cookies[:city_id]
  end

  def extract_from_ip
    address = BaiduApi.ip_to_city(request.remote_ip)
    City.find_by(name: address.split('|')[1]).try(:id) if address
  end

  def default_city
    City.find_by(name: "北京")
  end

  def set_city
    city_id = current_user_locale || extract_from_ip || default_city.id
    cookies[:city_id] = city_id
  end

  def current_city
    cookies[:city_id] || default_city.id
  end

  def current_city_name
    City.find(current_city).name
  end

  def current_city_id
    City.find(current_city).system_id
  end

  private

  def set_device_type
    request.variant = :phone if browser.mobile?
  end

end
