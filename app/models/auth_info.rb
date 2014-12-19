class AuthInfo < ActiveRecord::Base
  belongs_to :public_account
  has_many :user_authinfos
  has_many :users, :through => :user_authinfos

=begin
  validates :provider, presence: true, uniqueness: {scope: :user_id}
  validates :uid, presence: true, uniqueness: {scope: :provider}
=end

  validates_uniqueness_of :provider, :scope => [:uid]
  validates :provider, :uid,  presence:true

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
