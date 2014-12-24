class AuthInfo < ActiveRecord::Base
  belongs_to :public_account
  has_many :user_authinfos
  has_many :users, :through => :user_authinfos

  validates_uniqueness_of :provider, :scope => [:uid]
  validates :provider, :uid,  presence:true

end
