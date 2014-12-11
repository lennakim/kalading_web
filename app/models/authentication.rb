class Authentication < ActiveRecord::Base

  belongs_to :user

  validates :provider, presence: true, uniqueness: {scope: :user_id}
  validates :uid, presence: true, uniqueness: {scope: :provider}

  def self.locate auth
    uid            = auth["uid"].to_s
    provider       = auth["provider"]
    authentication = where(uid: uid, provider: provider).first

    if authentication
      authentication.update \
        uid:        auth["uid"],
        token:      auth["token"],
        provider:   auth["provider"],
        expires_at: auth["expires_at"]
    end

    authentication.user.update_user if authentication.try(:user)
    authentication
  end
end
