class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  http_basic_authenticate_with name: 'admin', password: 'KaLaDing'

  def sign_in user
    cookies[:LGT] = { value: user.update_user, expires: 30.days.from_now }
  end

  def signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(token: cookies[:LGT]) if cookies[:LGT]
  end

end
