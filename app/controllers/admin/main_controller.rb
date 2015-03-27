class Admin::MainController < ActionController::Base
  layout "admin"

  # http_basic_authenticate_with name: 'admin', password: 'KaLaDing'

  before_action :check_user
  helper_method :current_user

  def index
  end

  def current_user
    @current_user ||= User.find_by(token: cookies[:LGT]) if cookies[:LGT]
  end

  def check_user
    return redirect_to root_path if !current_user
    phone = current_user.phone_number
    if !Settings.editors.include?(phone) && !Settings.administrators.include?(phone)
      redirect_to root_path
    end
  end
end
