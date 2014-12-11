class SessionsController < ApplicationController

  def new
  end

  def create
    # fake login user
    fake_data = {
      "nickname" => 'test-user',
      "uid" => '15666666666',
      "provider" => 'phone',
      "phone_num" => '15666666666'
    }
    user = User.from_auth fake_data
    sign_in user

    redirect_to root_path
  end

  def by_phone
  end

  def callback
  end

  def auth_hash
    hash = request.env['omniauth.auth']
    {
      :provider    => hash.provider,
      :uid         => hash.uid,
      :token       => hash.credentials.token,
      :expires_at  => hash.credentials.expires_at,
      :nickname    => hash.info.nickname,
      :image       => hash.info.image,
      :description => hash.info.description
    }
  end


end
