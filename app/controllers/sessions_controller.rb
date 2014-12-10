class SessionsController < ApplicationController

  def new
  end

  def create
    # fake login user
    auth_hash = {
      "nickname" => 'test-user',
      "uid" => '15666666666',
      "provider" => 'phone',
      "phone_num" => '15666666666'
    }
    user = User.from_auth auth_hash
    sign_in user

    redirect_to root_path
  end

end
