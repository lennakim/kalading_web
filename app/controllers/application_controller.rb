class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?
  helper_method :current_city

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
    return current_user.city.name if current_user && current_user.city

    cookies[:city]
  end

  def extract_from_ip
    address = BaiduApi.ip_to_city(request.remote_ip)
    address.split('|')[1] if address
  end

  def set_city
    city = current_user_locale || extract_from_ip || "北京"
    cookies[:city] = city
  end

  def current_city
    cookies[:city] || "北京"
  end

  def current_city_id

  end

  private

  def set_device_type
    request.variant = :phone if browser.mobile?
  end

end
