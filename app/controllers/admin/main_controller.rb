class Admin::MainController < ActionController::Base
  layout "admin"
  http_basic_authenticate_with name: 'admin', password: 'KaLaDing'

  def index
  end
end
